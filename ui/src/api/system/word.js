import request from '@/utils/request'

// 查询停用语料库列表
export function listWord(query) {
  return request({
    url: '/system/word/list',
    method: 'get',
    params: query
  })
}

// 查询停用语料库详细
export function getWord(id) {
  return request({
    url: '/system/word/' + id,
    method: 'get'
  })
}

// 新增停用语料库
export function addWord(data) {
  return request({
    url: '/system/word',
    method: 'post',
    data: data
  })
}

// 修改停用语料库
export function updateWord(data) {
  return request({
    url: '/system/word',
    method: 'put',
    data: data
  })
}

// 删除停用语料库
export function delWord(id) {
  return request({
    url: '/system/word/' + id,
    method: 'delete'
  })
}
