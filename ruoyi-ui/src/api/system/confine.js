import request from '@/utils/request'

// 查询限流配置列表
export function listConfine(query) {
  return request({
    url: '/system/confine/list',
    method: 'get',
    params: query
  })
}

// 查询限流配置详细
export function getConfine(confineId) {
  return request({
    url: '/system/confine/' + confineId,
    method: 'get'
  })
}

// 新增限流配置
export function addConfine(data) {
  return request({
    url: '/system/confine',
    method: 'post',
    data: data
  })
}

// 修改限流配置
export function updateConfine(data) {
  return request({
    url: '/system/confine',
    method: 'put',
    data: data
  })
}

// 删除限流配置
export function delConfine(confineId) {
  return request({
    url: '/system/confine/' + confineId,
    method: 'delete'
  })
}

// 获取当前限流状态
export function getCurrentConfineStatus() {
  return request({
    url: '/system/confine/status',
    method: 'get'
  })
}

// 更新限流配置
export function updateConfineSettings(data) {
  return request({
    url: '/system/confine/settings',
    method: 'put',
    data: data
  })
}

// 注意：当前版本使用模拟数据，不依赖后端接口
// 如需连接后端，请取消注释上述接口调用
