import request from '@/utils/request'

// 查询模型预警列表
export function listWarning(query) {
  return request({
    url: '/system/warning/list',
    method: 'get',
    params: query
  })
}

// 查询模型预警详细
export function getWarning(id) {
  return request({
    url: '/system/warning/' + id,
    method: 'get'
  })
}

// 新增模型预警
export function addWarning(data) {
  return request({
    url: '/system/warning',
    method: 'post',
    data: data
  })
}

// 修改模型预警
export function updateWarning(data) {
  return request({
    url: '/system/warning',
    method: 'put',
    data: data
  })
}

// 删除模型预警
export function delWarning(id) {
  return request({
    url: '/system/warning/' + id,
    method: 'delete'
  })
}
