import request from '@/utils/request'

// 任务列表
export function getKG() {
  return request({
    url: '/system/kg/1',
    method: 'get',
  })
}

export function updateKG(graphData) {
  return request({
    url: '/system/kg/',
    method: 'put',
    data:{
        id:1,
        graphData:graphData
    }   
  })
}
