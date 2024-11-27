package com.example.notifymeapp.service;

import com.ibm.icu.text.Transliterator;
import org.springframework.stereotype.Service;

@Service
public class TransliterationService {
    public static final String CYRILLIC_TO_LATIN = "Russian-Latin/BGN";
    public static final String LATIN_TO_CYRILLIC = "Latin-Russian/BGN";

//    public String transliterate(String inputText) {
//        Transliterator toLatinTrans = Transliterator.getInstance(CYRILLIC_TO_LATIN);
//        return toLatinTrans.transliterate(inputText);
//    }

    public String translitRuToEn(String inputText) {
        Transliterator toLatinTrans = Transliterator.getInstance(CYRILLIC_TO_LATIN);
        return toLatinTrans.transliterate(inputText);
    }

    public String translitEnToRu(String inputText) {
        Transliterator toCyrillicTrans = Transliterator.getInstance(LATIN_TO_CYRILLIC);
        return toCyrillicTrans.transliterate(inputText);
    }
}
