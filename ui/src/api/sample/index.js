import request from '@/utils/request'

// 查询样本列表
export function listSample(query) {
  return request({
    url: '/sample/list',
    method: 'get',
    params: query
  })
}

// 查询样本详细
export function getSample(sampleId) {
  return request({
    url: '/sample/' + sampleId,
    method: 'get'
  })
}

// 新增样本
export function addSample(data) {
  return request({
    url: '/sample',
    method: 'post',
    data: data
  })
}

// 修改样本
export function updateSample(data) {
  return request({
    url: '/sample',
    method: 'put',
    data: data
  })
}

// 删除样本
export function delSample(sampleId) {
  return request({
    url: '/sample/' + sampleId,
    method: 'delete'
  })
}

// 样本上传
export function uploadSample(data) {
  return request({
    url: '/sample/upload',
    method: 'post',
    data: data
  })
}

// 样本打乱
export function shuffleSample() {
  return request({
    url: '/sample/shuffle',
    method: 'post'
  })
}

// 样本导出
export function exportSample(query) {
  return request({
    url: '/sample/export',
    method: 'get',
    params: query
  })
}

// 获取样本统计
export function getSampleStatistics() {
  return request({
    url: '/sample/statistics',
    method: 'get'
  })
}

// 获取版本列表
export function getVersionList() {
  return request({
    url: '/sample/version/list',
    method: 'get'
  })
}

// 创建新版本
export function createVersion(data) {
  return request({
    url: '/sample/version',
    method: 'post',
    data: data
  })
}

// 恢复到指定版本
export function restoreVersion(versionId) {
  return request({
    url: '/sample/version/restore/' + versionId,
    method: 'post'
  })
}

// 标准化检测
export function standardizationCheck() {
  return request({
    url: '/sample/standardization/check',
    method: 'post'
  })
}

// 备份样本数据
export function backupSample() {
  return request({
    url: '/sample/backup',
    method: 'post'
  })
} 