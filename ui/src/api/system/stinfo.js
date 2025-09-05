import request from '@/utils/request'

// 查询变电站信息列表
export function listStinfo(query) {
  return request({
    url: '/system/stinfo/list',
    method: 'get',
    params: query
  })
}

// 查询变电站信息详细
export function getStinfo(id) {
  return request({
    url: '/system/stinfo/' + id,
    method: 'get'
  })
}

// 新增变电站信息
export function addStinfo(data) {
  return request({
    url: '/system/stinfo',
    method: 'post',
    data: data
  })
}

// 修改变电站信息
export function updateStinfo(data) {
  return request({
    url: '/system/stinfo',
    method: 'put',
    data: data
  })
}

// 删除变电站信息
export function delStinfo(id) {
  return request({
    url: '/system/stinfo/' + id,
    method: 'delete'
  })
}
