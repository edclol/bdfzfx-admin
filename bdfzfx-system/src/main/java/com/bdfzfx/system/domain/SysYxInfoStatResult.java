package com.bdfzfx.system.domain;

import java.io.Serializable;
import java.util.List;

/**
 * 样本库统计结果DTO
 */
public class SysYxInfoStatResult implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private Integer total;
    private List<StatItem> categories;
    
    // 构造函数
    public SysYxInfoStatResult() {}
    
    public SysYxInfoStatResult(Integer total, List<StatItem> categories) {
        this.total = total;
        this.categories = categories;
    }
    
    // getter and setter
    public Integer getTotal() {
        return total;
    }
    
    public void setTotal(Integer total) {
        this.total = total;
    }
    
    public List<StatItem> getCategories() {
        return categories;
    }
    
    public void setCategories(List<StatItem> categories) {
        this.categories = categories;
    }
}
