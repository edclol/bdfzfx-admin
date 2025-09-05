import request from '@/utils/request'

// 查询样本数据版本管理列表
export function listVersion(query) {
  return request({
    url: '/system/version/list',
    method: 'get',
    params: query
  })
}

// 查询样本数据版本管理详细
export function getVersion(id) {
  return request({
    url: '/system/version/' + id,
    method: 'get'
  })
}

// 新增样本数据版本管理
export function addVersion(data) {
  return request({
    url: '/system/version',
    method: 'post',
    data: data
  })
}

// 修改样本数据版本管理
export function updateVersion(data) {
  return request({
    url: '/system/version',
    method: 'put',
    data: data
  })
}

// 删除样本数据版本管理
export function delVersion(id) {
  return request({
    url: '/system/version/' + id,
    method: 'delete'
  })
}
