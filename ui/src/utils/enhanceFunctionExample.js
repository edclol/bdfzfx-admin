/**
 * 增强函数使用示例
 * 展示如何在其他组件中使用增强函数
 */

import { executeEnhanceFunction } from './enhanceFunction'

/**
 * 示例：在数据处理中使用增强函数
 * @param {Array} dataList - 数据列表
 * @returns {Array} 处理后的数据列表
 */
export function processDataWithEnhanceFunction(dataList) {
  return dataList.map(item => {
    // 对设备名称应用增强函数
    if (item.deviceName) {
      item.deviceName = executeEnhanceFunction(item.deviceName)
    }
    
    // 对厂站名称应用增强函数
    if (item.stationName) {
      item.stationName = executeEnhanceFunction(item.stationName)
    }
    
    return item
  })
}

/**
 * 示例：在表单验证中使用增强函数
 * @param {string} inputValue - 输入值
 * @returns {string} 处理后的值
 */
export function validateAndProcessInput(inputValue) {
  // 先进行基本的验证
  if (!inputValue || typeof inputValue !== 'string') {
    return inputValue
  }
  
  // 应用增强函数处理
  return executeEnhanceFunction(inputValue)
}

/**
 * 示例：在搜索功能中使用增强函数
 * @param {string} searchKeyword - 搜索关键词
 * @returns {string} 处理后的搜索关键词
 */
export function processSearchKeyword(searchKeyword) {
  if (!searchKeyword) {
    return searchKeyword
  }
  
  // 应用增强函数处理搜索关键词
  return executeEnhanceFunction(searchKeyword)
}

/**
 * 示例：在数据导出中使用增强函数
 * @param {Object} exportData - 导出数据
 * @returns {Object} 处理后的导出数据
 */
export function processExportData(exportData) {
  const processedData = { ...exportData }
  
  // 处理所有字符串字段
  Object.keys(processedData).forEach(key => {
    if (typeof processedData[key] === 'string') {
      processedData[key] = executeEnhanceFunction(processedData[key])
    }
  })
  
  return processedData
}
