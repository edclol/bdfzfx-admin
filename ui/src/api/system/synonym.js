import request from '@/utils/request'

// 查询同义词库列表
export function listSynonym(query) {
  return request({
    url: '/system/synonym/list',
    method: 'get',
    params: query
  })
}

// 查询同义词库详细
export function getSynonym(id) {
  return request({
    url: '/system/synonym/' + id,
    method: 'get'
  })
}

// 新增同义词库
export function addSynonym(data) {
  return request({
    url: '/system/synonym',
    method: 'post',
    data: data
  })
}

// 修改同义词库
export function updateSynonym(data) {
  return request({
    url: '/system/synonym',
    method: 'put',
    data: data
  })
}

// 删除同义词库
export function delSynonym(id) {
  return request({
    url: '/system/synonym/' + id,
    method: 'delete'
  })
}
