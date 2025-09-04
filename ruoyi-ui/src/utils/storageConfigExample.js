/**
 * 存储配置使用示例
 * 展示如何在其他组件中使用存储配置
 */

import { getStorageConfig } from './storageConfig'

/**
 * 示例：在文件上传中使用存储配置
 * @param {File} file - 上传的文件
 * @returns {Object} 上传配置
 */
export function getUploadConfig(file) {
  const storageConfig = getStorageConfig()
  
  return {
    uploadPath: storageConfig.dataPath + '/uploads',
    logPath: storageConfig.logPath + '/upload.log',
    fileName: file.name
  }
}

/**
 * 示例：在数据导出中使用存储配置
 * @param {string} fileName - 文件名
 * @returns {Object} 导出配置
 */
export function getExportConfig(fileName) {
  const storageConfig = getStorageConfig()
  
  return {
    exportPath: storageConfig.dataPath + '/exports',
    logPath: storageConfig.logPath + '/export.log',
    fileName: fileName
  }
}

/**
 * 示例：在日志记录中使用存储配置
 * @param {string} logLevel - 日志级别
 * @param {string} message - 日志消息
 * @returns {Object} 日志配置
 */
export function getLogConfig(logLevel, message) {
  const storageConfig = getStorageConfig()
  
  return {
    logPath: storageConfig.logPath + '/app.log',
    logLevel: logLevel,
    message: message,
    timestamp: new Date().toISOString()
  }
}

/**
 * 示例：在数据备份中使用存储配置
 * @returns {Object} 备份配置
 */
export function getBackupConfig() {
  const storageConfig = getStorageConfig()
  
  return {
    backupPath: storageConfig.dataPath + '/backup',
    logPath: storageConfig.logPath + '/backup.log',
    backupTime: new Date().toISOString()
  }
}

/**
 * 示例：检查存储路径是否有效
 * @returns {boolean} 路径是否有效
 */
export function validateStoragePaths() {
  const storageConfig = getStorageConfig()
  
  // 检查数据路径
  if (!storageConfig.dataPath || storageConfig.dataPath.trim() === '') {
    return false
  }
  
  // 检查日志路径
  if (!storageConfig.logPath || storageConfig.logPath.trim() === '') {
    return false
  }
  
  return true
}
