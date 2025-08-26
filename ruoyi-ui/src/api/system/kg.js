import request from '@/utils/request'

// 查询知识图谱JSON存储列表
export function listKg(query) {
  return request({
    url: '/system/kg/list',
    method: 'get',
    params: query
  })
}

// 查询知识图谱JSON存储详细
export function getKg(id) {
  return request({
    url: '/system/kg/' + id,
    method: 'get'
  })
}

// 新增知识图谱JSON存储
export function addKg(data) {
  return request({
    url: '/system/kg',
    method: 'post',
    data: data
  })
}

// 修改知识图谱JSON存储
export function updateKg(data) {
  return request({
    url: '/system/kg',
    method: 'put',
    data: data
  })
}

// 删除知识图谱JSON存储
export function delKg(id) {
  return request({
    url: '/system/kg/' + id,
    method: 'delete'
  })
}
