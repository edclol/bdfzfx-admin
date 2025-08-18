package com.bdfzfx.system.domain;

import java.io.Serializable;

/**
 * 统计项实体类
 */
public class StatItem implements Serializable {
    private static final long serialVersionUID = 1L;

    private String name;
    private Integer value;

    public StatItem(String name, Integer value) {
        this.name = name;
        this.value = value;
    }

    // getter and setter
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getValue() {
        return value;
    }

    public void setValue(Integer value) {
        this.value = value;
    }
}
