package com.example.notifymeapp.service;

import com.example.notifymeapp.config.BotConfig;
import com.example.notifymeapp.entity.Chat;
import com.vdurmont.emoji.EmojiParser;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.telegram.telegrambots.bots.TelegramLongPollingBot;
import org.telegram.telegrambots.meta.api.methods.AnswerInlineQuery;
import org.telegram.telegrambots.meta.api.methods.commands.SetMyCommands;
import org.telegram.telegrambots.meta.api.methods.groupadministration.LeaveChat;
import org.telegram.telegrambots.meta.api.methods.send.SendMessage;
import org.telegram.telegrambots.meta.api.objects.Message;
import org.telegram.telegrambots.meta.api.objects.Update;
import org.telegram.telegrambots.meta.api.objects.commands.BotCommand;
import org.telegram.telegrambots.meta.api.objects.commands.scope.BotCommandScopeDefault;
import org.telegram.telegrambots.meta.api.objects.inlinequery.InlineQuery;
import org.telegram.telegrambots.meta.api.objects.inlinequery.inputmessagecontent.InputTextMessageContent;
import org.telegram.telegrambots.meta.api.objects.inlinequery.result.InlineQueryResult;
import org.telegram.telegrambots.meta.api.objects.inlinequery.result.InlineQueryResultArticle;
import org.telegram.telegrambots.meta.exceptions.TelegramApiException;

import java.util.ArrayList;
import java.util.List;

@Component
@Slf4j
public class TelegramBot extends TelegramLongPollingBot {
    final BotConfig config;
    private final ChatService chatService;
    private final KeyboardLayoutConverter keyboardLayoutConverter;
    private final TransliterationService transliterationService;

    static final String HELP_TEXT = "This bot is created to send notifications on services.\n\n" +
            "Type /start to see a welcome message\n" +
            "Type /help to see this message again\n" +
            "Type /translit_ru2en to transliterate Cyrillic text to Latin\n" +
//            "Type /translit_en2ru to transliterate Latin text to Cyrillic\n" +
            "Type /en2ru to convert English layout to Russian\n" +
            "Type /ru2en to convert Russian layout to English\n";
    static final String ERROR_TEXT = "Error occurred: ";

    public TelegramBot(BotConfig config, ChatService chatService, KeyboardLayoutConverter keyboardLayoutConverter, TransliterationService transliterationService) {
        this.config = config;
        this.chatService = chatService;
        this.keyboardLayoutConverter = keyboardLayoutConverter;
        this.transliterationService = transliterationService;
        List<BotCommand> listOfCommands = new ArrayList<>();
        listOfCommands.add(new BotCommand("/start", "get a welcome message"));
        listOfCommands.add(new BotCommand("/help", "get help"));
        listOfCommands.add(new BotCommand("/translit_ru2en", "transliterate Cyrillic text to Latin"));
//        listOfCommands.add(new BotCommand("/translit_en2ru", "transliterate Latin text to Cyrillic"));
        listOfCommands.add(new BotCommand("/en2ru", "convert English layout to Russian"));
        listOfCommands.add(new BotCommand("/ru2en", "convert Russian layout to English"));
        try {
            this.execute(new SetMyCommands(listOfCommands, new BotCommandScopeDefault(), null));
        } catch (TelegramApiException e) {
            log.error("Error setting bot command list: " + e.getMessage());
        }
    }

    @Override
    public String getBotUsername() {
        return config.getBotName();
    }

    @Override
    public String getBotToken() {
        return config.getToken();
    }
    private void saveOrUpdateChat(org.telegram.telegrambots.meta.api.objects.Chat tgChat) {
        Chat existingChat = chatService.getChatById(tgChat.getId());
        String newChatName = tgChat.getTitle() != null ? tgChat.getTitle() : tgChat.getUserName();
        System.out.println(newChatName);
        if (existingChat == null) {
            Chat newChat = Chat.builder()
                    .chatId(tgChat.getId())
                    .chatName(newChatName)
                    .build();
            chatService.saveChat(newChat);
        } else if (!existingChat.getChatName().equals(newChatName)) {
            existingChat.setChatName(newChatName);
            chatService.updateChat(existingChat);
        }
    }
    @Override
    public void onUpdateReceived(Update update) {
        if (update.hasMessage()) {
            Message message = update.getMessage();
            if (message.hasText()) {
                processMessage(message);
            }

            if (message.getNewChatMembers() != null) {
                List<org.telegram.telegrambots.meta.api.objects.User> newMembers = message.getNewChatMembers();
                for (org.telegram.telegrambots.meta.api.objects.User member : newMembers) {
                    if (member.getUserName().equals(getBotUsername())) {
                        saveOrUpdateChat(message.getChat());
                        break;
                    }
                }
            }

            if (message.getGroupchatCreated() != null && message.getGroupchatCreated()) {
                saveOrUpdateChat(message.getChat());
            } else {
                // Проверка и обновление имени чата при каждом новом сообщении
                saveOrUpdateChat(message.getChat());
            }
        }

        if (update.hasInlineQuery()) {
            processInlineQuery(update.getInlineQuery());
        }

        // Проверка обновлений для событий изменения участников
        if (update.hasMyChatMember()) {
            saveOrUpdateChat(update.getMyChatMember().getChat());
        }
    }
    private void processInlineQuery(InlineQuery inlineQuery) {
        String query = inlineQuery.getQuery().trim();
        List<InlineQueryResult> results = new ArrayList<>();

        if (!query.isEmpty()) {
            if (query.startsWith("en2ru")) {
                String text = query.replace("en2ru", "").trim();
                String convertedText = keyboardLayoutConverter.convertEnToRu(text);
                results.add(createInlineQueryResultArticle("en2ru", text, convertedText));
            } else if (query.startsWith("ru2en")) {
                String text = query.replace("ru2en", "").trim();
                String convertedText = keyboardLayoutConverter.convertRuToEn(text);
                results.add(createInlineQueryResultArticle("ru2en", text, convertedText));
            }
//            else if (query.startsWith("translit_en2ru")) {
//                String text = query.replace("translit_en2ru", "").trim();
//                String convertedText = transliterationService.translitEnToRu(text);
//                results.add(createInlineQueryResultArticle("translit_en2ru", text, convertedText));
//            }
        else if (query.startsWith("translit_ru2en")) {
                String text = query.replace("translit_ru2en", "").trim();
                String convertedText = transliterationService.translitRuToEn(text);
                results.add(createInlineQueryResultArticle("translit_ru2en", text, convertedText));
            }
        }

        AnswerInlineQuery answerInlineQuery = new AnswerInlineQuery();
        answerInlineQuery.setInlineQueryId(inlineQuery.getId());
        answerInlineQuery.setResults(results);
        answerInlineQuery.setCacheTime(0); // Disable caching for instant updates

        try {
            execute(answerInlineQuery);
        } catch (TelegramApiException e) {
            log.error("Error processing inline query: " + e.getMessage());
        }
    }

    private InlineQueryResultArticle createInlineQueryResultArticle(String command, String queryText, String resultText) {
        InputTextMessageContent messageContent = new InputTextMessageContent();
        messageContent.setMessageText(resultText);

        return new InlineQueryResultArticle(command + queryText, "Result for: " + queryText, messageContent);
    }

    public void leaveChat(Long chatId) {
        LeaveChat leaveChat = new LeaveChat();
        leaveChat.setChatId(chatId.toString());
        try {
            execute(leaveChat);
            log.info("Successfully left chat: " + chatId);
        } catch (TelegramApiException e) {
            log.error("Failed to leave chat: " + chatId, e);
        }
    }

    private void saveChat(org.telegram.telegrambots.meta.api.objects.Chat tgChat) {
        if (chatService.getChatById(tgChat.getId()) == null) {
            Chat chat = Chat.builder()
                    .chatId(tgChat.getId())
                    .chatName(tgChat.getTitle() != null ? tgChat.getTitle() : tgChat.getUserName())
                    .build();
            chatService.saveChat(chat);
        }
    }

    private void processMessage(Message message) {
        String text = message.getText();
        Long chatId = message.getChatId();

        // Remove bot's username from the command, if present
        if (text.contains("@")) {
            text = text.split("@")[0];
        }

        // Handle commands
        switch (text.split(" ")[0]) {
            case "/start":
                showStart(chatId, message.getFrom().getFirstName());
                break;
            case "/help":
                prepareAndSendMessage(chatId, HELP_TEXT); // Display the command menu
                break;
            case "/translit_ru2en":
                transliterateRuToEn(chatId, message); // Transliterate command
                break;
//            case "/translit_en2ru":
//                transliterateEnToRu(chatId, message); // Transliterate command
//                break;
            case "/en2ru":
                convertLayout(chatId, message, "/en2ru"); // English to Russian command
                break;
            case "/ru2en":
                convertLayout(chatId, message, "/ru2en"); // Russian to English command
                break;
            default:
                // If none of the above, handle as normal message or unknown command
//                commandNotFound(chatId);
                break;
        }
    }

    private void convertLayout(Long chatId, Message message, String command) {
        String text = message.getText().replace(command, "").trim();
        text = text.replace('@'+getBotUsername(), "").trim();
        if (!text.isEmpty()) {
            String convertedText = null;
            switch (command) {
                case "/en2ru":
                    convertedText = keyboardLayoutConverter.convertEnToRu(text);
                    break;
                case "/ru2en":
                    convertedText = keyboardLayoutConverter.convertRuToEn(text);
                    break;
                default:
                    break;
            }
            prepareAndSendMessage(chatId, convertedText);
        } else if (message.isReply()) {
            Message repliedMessage = message.getReplyToMessage();
            String originalText = repliedMessage.getText();
            String convertedText = null;
            switch (command) {
                case "/en2ru":
                    convertedText = keyboardLayoutConverter.convertEnToRu(originalText);
                    break;
                case "/ru2en":
                    convertedText = keyboardLayoutConverter.convertRuToEn(originalText);
                    break;
                default:
                    break;
            }
            prepareAndSendMessage(chatId, convertedText);
        } else {
            prepareAndSendMessage(chatId, "Please reply to the message you want to convert with the " + command + " command, or provide text after the command.");
        }
    }

    private void transliterateRuToEn(Long chatId, Message message) {
        String text = message.getText().replace("/translit_ru2en", "").trim();
        text = text.replace('@'+getBotUsername(), "").trim();
        if (!text.isEmpty()) {
            String convertedText = transliterationService.translitRuToEn(text);
            prepareAndSendMessage(chatId, convertedText);
        } else if (message.isReply()) {
            Message repliedMessage = message.getReplyToMessage();
            String originalText = repliedMessage.getText();
            String convertedText = transliterationService.translitRuToEn(originalText);
            prepareAndSendMessage(chatId, convertedText);
        } else {
            prepareAndSendMessage(chatId, "Please reply to the message you want to transliterate with the /translit command, or provide text after the command.");
        }
    }

    private void transliterateEnToRu(Long chatId, Message message) {
        String text = message.getText().replace("/translit_en2ru", "").trim();
        text = text.replace('@'+getBotUsername(), "").trim();
        if (!text.isEmpty()) {
            String convertedText = transliterationService.translitEnToRu(text);
            prepareAndSendMessage(chatId, convertedText);
        } else if (message.isReply()) {
            Message repliedMessage = message.getReplyToMessage();
            String originalText = repliedMessage.getText();
            String convertedText = transliterationService.translitEnToRu(originalText);
            prepareAndSendMessage(chatId, convertedText);
        } else {
            prepareAndSendMessage(chatId, "Please reply to the message you want to transliterate with the /translit command, or provide text after the command.");
        }
    }


    private void showStart(long chatId, String name) {
        String text = EmojiParser.parseToUnicode(
                "Hi, " + name + "! :smile:" + " Nice to meet you!\n");
        prepareAndSendMessage(chatId, text);
    }

    private void commandNotFound(long chatId) {
        String answer = EmojiParser.parseToUnicode(
                "Command not recognized, please verify and try again :stuck_out_tongue_winking_eye: ");
        prepareAndSendMessage(chatId, answer);
    }

    private void prepareAndSendMessage(Long chatId, String textToSend) {
        SendMessage message = new SendMessage();
        message.setChatId(String.valueOf(chatId));
        message.setText(textToSend);
        executeMessage(message);
    }

    private void executeMessage(SendMessage message) {
        try {
            execute(message);
        } catch (TelegramApiException e) {
            log.error(ERROR_TEXT + e.getMessage());
        }
    }

    public void sendMessageToChats(String messageText, List<Long> chatIds) {
        for (Long chatId : chatIds) {
            SendMessage message = new SendMessage();
            message.setChatId(String.valueOf(chatId));
            message.setText(messageText);
            executeMessage(message);
        }
    }
}

