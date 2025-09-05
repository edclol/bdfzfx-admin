import request from '@/utils/request'

// 任务列表
export function listAnnotationTask(query) {
  return request({
    url: '/annotation/task/list',
    method: 'get',
    params: query
  })
}

// 新增任务
export function addAnnotationTask(data) {
  return request({
    url: '/annotation/task',
    method: 'post',
    data: data
  })
}

// 开始标注
export function startAnnotationTask(taskId) {
  return request({
    url: '/annotation/task/start/' + taskId,
    method: 'post'
  })
}

// 继续标注
export function continueAnnotationTask(taskId) {
  return request({
    url: '/annotation/task/continue/' + taskId,
    method: 'post'
  })
}

// 回收任务
export function recycleAnnotationTask(taskId) {
  return request({
    url: '/annotation/task/recycle/' + taskId,
    method: 'post'
  })
}

// 一键分词
export function oneClickTokenize() {
  return request({
    url: '/annotation/tokenize',
    method: 'post'
  })
}

// 同义词 - 列表
export function listSynonym(query) {
  return request({
    url: '/annotation/synonym/list',
    method: 'get',
    params: query
  })
}

// 同义词 - 新增
export function addSynonym(data) {
  return request({
    url: '/annotation/synonym',
    method: 'post',
    data: data
  })
}

// 同义词 - 修改
export function updateSynonym(data) {
  return request({
    url: '/annotation/synonym',
    method: 'put',
    data: data
  })
}

// 同义词 - 删除
export function delSynonym(id) {
  return request({
    url: '/annotation/synonym/' + id,
    method: 'delete'
  })
} 