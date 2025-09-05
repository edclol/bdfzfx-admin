import request from '@/utils/request'

// 查询映射结果列表
export function listMpresult(query) {
  return request({
    url: '/system/mpresult/list',
    method: 'get',
    params: query
  })
}

// 查询映射结果详细
export function getMpresult(id) {
  return request({
    url: '/system/mpresult/' + id,
    method: 'get'
  })
}

// 新增映射结果
export function addMpresult(data) {
  return request({
    url: '/system/mpresult',
    method: 'post',
    data: data
  })
}

// 修改映射结果
export function updateMpresult(data) {
  return request({
    url: '/system/mpresult',
    method: 'put',
    data: data
  })
}

// 删除映射结果
export function delMpresult(id) {
  return request({
    url: '/system/mpresult/' + id,
    method: 'delete'
  })
}
