import request from '@/utils/request'

// 查询信号信息列表
export function listInfo(query) {
  return request({
    url: '/system/info/list',
    method: 'get',
    params: query
  })
}

// 查询信号信息详细
export function getInfo(id) {
  return request({
    url: '/system/info/' + id,
    method: 'get'
  })
}

// 新增信号信息
export function addInfo(data) {
  return request({
    url: '/system/info',
    method: 'post',
    data: data
  })
}

// 修改信号信息
export function updateInfo(data) {
  return request({
    url: '/system/info',
    method: 'put',
    data: data
  })
}

// 删除信号信息
export function delInfo(id) {
  return request({
    url: '/system/info/' + id,
    method: 'delete'
  })
}
