import request from '@/utils/request'

// 查询遥信调用记录列表
export function listCall(query) {
  return request({
    url: '/system/call/list',
    method: 'get',
    params: query
  })
}

// 查询遥信调用记录详细
export function getCall(id) {
  return request({
    url: '/system/call/' + id,
    method: 'get'
  })
}

// 新增遥信调用记录
export function addCall(data) {
  return request({
    url: '/system/call',
    method: 'post',
    data: data
  })
}

// 修改遥信调用记录
export function updateCall(data) {
  return request({
    url: '/system/call',
    method: 'put',
    data: data
  })
}

// 删除遥信调用记录
export function delCall(id) {
  return request({
    url: '/system/call/' + id,
    method: 'delete'
  })
}
