/**
 * 增强函数工具类
 * 用于加载和执行用户配置的增强函数
 */

/**
 * 从localStorage获取增强函数代码
 * @returns {string} 函数代码
 */
export function getEnhanceFunctionCode() {
  return localStorage.getItem('enhanceFunctionCode') || getDefaultFunctionCode()
}

/**
 * 获取默认的增强函数代码
 * @returns {string} 默认函数代码
 */
export function getDefaultFunctionCode() {
  return `/**
 * 将字符串中的 "xn_公用间隔" 替换为 "默认设备"
 * @param {string} input - 输入的字符串
 * @returns {string} 处理后的字符串
 */
function preProcess(input) {
    if (typeof input !== 'string') {
        console.error('输入必须是字符串类型');
        return input;
    }
    return input.replace(/xn_公用间隔/g, '默认设备');
}`
}

/**
 * 执行增强函数
 * @param {string} input - 输入字符串
 * @returns {string} 处理后的字符串
 */
export function executeEnhanceFunction(input) {
  try {
    const functionCode = getEnhanceFunctionCode()
    const executeFunction = new Function('input', functionCode + '\nreturn preProcess(input);')
    return executeFunction(input)
  } catch (error) {
    console.error('增强函数执行错误:', error)
    return input // 如果执行失败，返回原输入
  }
}

/**
 * 检查增强函数是否可用
 * @returns {boolean} 是否可用
 */
export function isEnhanceFunctionAvailable() {
  try {
    const functionCode = getEnhanceFunctionCode()
    new Function(functionCode)
    return true
  } catch (error) {
    return false
  }
}

/**
 * 保存增强函数代码到localStorage
 * @param {string} code - 函数代码
 * @returns {boolean} 是否保存成功
 */
export function saveEnhanceFunctionCode(code) {
  try {
    // 验证函数语法
    new Function(code)
    localStorage.setItem('enhanceFunctionCode', code)
    return true
  } catch (error) {
    console.error('函数语法错误:', error)
    return false
  }
}
