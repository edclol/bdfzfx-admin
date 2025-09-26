import request from '@/utils/request'

// 查询间隔信息管理列表
export function listJginfo(query) {
  return request({
    url: '/system/jginfo/list',
    method: 'get',
    params: query
  })
}

// 查询间隔信息管理详细
export function getJginfo(id) {
  return request({
    url: '/system/jginfo/' + id,
    method: 'get'
  })
}

// 新增间隔信息管理
export function addJginfo(data) {
  return request({
    url: '/system/jginfo',
    method: 'post',
    data: data
  })
}

// 修改间隔信息管理
export function updateJginfo(data) {
  return request({
    url: '/system/jginfo',
    method: 'put',
    data: data
  })
}

// 删除间隔信息管理
export function delJginfo(id) {
  return request({
    url: '/system/jginfo/' + id,
    method: 'delete'
  })
}
