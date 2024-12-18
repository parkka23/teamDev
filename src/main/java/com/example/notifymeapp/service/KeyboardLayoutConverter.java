package com.example.notifymeapp.service;

import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class KeyboardLayoutConverter {

    private static final Map<Character, Character> EN_TO_RU_MAP = new HashMap<>();
    private static final Map<Character, Character> RU_TO_EN_MAP = new HashMap<>();

    static {
        String en = "qwertyuiop[]asdfghjkl;'zxcvbnm,./";
        String ru = "йцукенгшщзхъфывапролджэячсмитьбю.";

        for (int i = 0; i < en.length(); i++) {
            EN_TO_RU_MAP.put(en.charAt(i), ru.charAt(i));
            RU_TO_EN_MAP.put(ru.charAt(i), en.charAt(i));
        }

        // Add uppercase mappings
        String enUpper = "QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>?";
        String ruUpper = "ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ,";

        for (int i = 0; i < enUpper.length(); i++) {
            EN_TO_RU_MAP.put(enUpper.charAt(i), ruUpper.charAt(i));
            RU_TO_EN_MAP.put(ruUpper.charAt(i), enUpper.charAt(i));
        }
    }
    public String convertEnToRu(String text) {
        StringBuilder convertedText = new StringBuilder();
        for (char ch : text.toCharArray()) {
            if (EN_TO_RU_MAP.containsKey(ch)) {
                convertedText.append(EN_TO_RU_MAP.get(ch));
            } else {
                convertedText.append(ch);
            }
        }
        return convertedText.toString();
    }
    public String convertRuToEn(String text) {
        StringBuilder convertedText = new StringBuilder();
        for (char ch : text.toCharArray()) {
            if (RU_TO_EN_MAP.containsKey(ch)) {
                convertedText.append(RU_TO_EN_MAP.get(ch));
            } else {
                convertedText.append(ch);
            }
        }
        return convertedText.toString();
    }

}