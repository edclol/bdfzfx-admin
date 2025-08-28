package com.bdfzfx.system.domain;

import java.util.List;

/**
 * 分词处理实体类
 * 用于接收分词请求参数和返回分词结果
 */
public class WordSegment {
    /**
     * 需要分词的文本内容
     */
    private String words;
    
    /**
     * 分词结果列表
     */
    private List<String> wordList;
    
    /**
     * 分词数量
     */
    private Integer wordCount;

    public WordSegment() {
    }

    public WordSegment(String words) {
        this.words = words;
    }

    public WordSegment(String words, List<String> wordList) {
        this.words = words;
        this.wordList = wordList;
        if (wordList != null) {
            this.wordCount = wordList.size();
        }
    }

    public String getWords() {
        return words;
    }

    public void setWords(String words) {
        this.words = words;
    }

    public List<String> getWordList() {
        return wordList;
    }

    public void setWordList(List<String> wordList) {
        this.wordList = wordList;
        if (wordList != null) {
            this.wordCount = wordList.size();
        }
    }

    public Integer getWordCount() {
        return wordCount;
    }

    public void setWordCount(Integer wordCount) {
        this.wordCount = wordCount;
    }
}
