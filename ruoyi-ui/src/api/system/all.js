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


// 获取样本库统计
export function getAllStat() {
  return request({
    url: '/system/all/stat',
    method: 'get'
  })
}

// 获取样本版本列表
export function getVersion() {
  return request({
    url: '/system/version/list',
    method: 'get'
  })
}

// 新增：随机导出（返回二进制）
export function getRandomExport(query) {
  return request({
    url: '/system/all/export/random',
    method: 'post',
    params: query,
    responseType: 'blob'
  })
}

export function importTemplate() {
  return request({
    url: '/system/all/importTemplate',
    method: 'get',
  })
}
