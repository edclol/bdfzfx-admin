import request from '@/utils/request'

// 查询典型监控信息管理列表
export function listMonitor(query) {
  return request({
    url: '/system/monitor/list',
    method: 'get',
    params: query
  })
}

// 查询典型监控信息管理详细
export function getMonitor(id) {
  return request({
    url: '/system/monitor/' + id,
    method: 'get'
  })
}

// 新增典型监控信息管理
export function addMonitor(data) {
  return request({
    url: '/system/monitor',
    method: 'post',
    data: data
  })
}

// 修改典型监控信息管理
export function updateMonitor(data) {
  return request({
    url: '/system/monitor',
    method: 'put',
    data: data
  })
}

// 删除典型监控信息管理
export function delMonitor(id) {
  return request({
    url: '/system/monitor/' + id,
    method: 'delete'
  })
}

//数据统计
export function dataStatistics() {
  return request({
    url: '/system/monitor/stat',
    method: 'get',
  })
}