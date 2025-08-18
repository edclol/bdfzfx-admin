import request from '@/utils/request'

// 查询样本库列表
export function listAll(query) {
  return request({
    url: '/system/all/list',
    method: 'get',
    params: query
  })
}

// 查询样本库详细
export function getAll(id) {
  return request({
    url: '/system/all/' + id,
    method: 'get'
  })
}

// 新增样本库
export function addAll(data) {
  return request({
    url: '/system/all',
    method: 'post',
    data: data
  })
}

// 修改样本库
export function updateAll(data) {
  return request({
    url: '/system/all',
    method: 'put',
    data: data
  })
}

// 删除样本库
export function delAll(id) {
  return request({
    url: '/system/all/' + id,
    method: 'delete'
  })
}
