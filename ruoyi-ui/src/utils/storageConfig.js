/**
 * 存储配置工具类
 * 用于管理存储配置的本地存储
 */

/**
 * 默认存储配置
 */
const DEFAULT_STORAGE_CONFIG = {
  dataPath: '/data/bdfufx',
  logPath: '/data/log/bdfzfx'
}

/**
 * 从localStorage获取存储配置
 * @returns {Object} 存储配置对象
 */
export function getStorageConfig() {
  try {
    const savedConfig = localStorage.getItem('storageConfig')
    if (savedConfig) {
      return JSON.parse(savedConfig)
    }
  } catch (error) {
    console.error('获取存储配置失败:', error)
  }
  return { ...DEFAULT_STORAGE_CONFIG }
}

/**
 * 保存存储配置到localStorage
 * @param {Object} config - 存储配置对象
 * @returns {boolean} 是否保存成功
 */
export function saveStorageConfig(config) {
  try {
    // 验证配置对象
    if (!config || typeof config !== 'object') {
      throw new Error('配置必须是对象类型')
    }
    
    // 验证必要字段
    if (!config.dataPath || !config.logPath) {
      throw new Error('数据路径和日志路径不能为空')
    }
    
    localStorage.setItem('storageConfig', JSON.stringify(config))
    return true
  } catch (error) {
    console.error('保存存储配置失败:', error)
    return false
  }
}

/**
 * 重置存储配置为默认值
 * @returns {boolean} 是否重置成功
 */
export function resetStorageConfig() {
  try {
    localStorage.setItem('storageConfig', JSON.stringify(DEFAULT_STORAGE_CONFIG))
    return true
  } catch (error) {
    console.error('重置存储配置失败:', error)
    return false
  }
}

/**
 * 检查存储配置是否存在
 * @returns {boolean} 是否存在配置
 */
export function hasStorageConfig() {
  return localStorage.getItem('storageConfig') !== null
}

/**
 * 获取默认存储配置
 * @returns {Object} 默认配置对象
 */
export function getDefaultStorageConfig() {
  return { ...DEFAULT_STORAGE_CONFIG }
}
