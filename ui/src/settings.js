module.exports = {
  /**
   * 网页标题
   */
  title: process.env.VUE_APP_TITLE,

  /**
   * 侧边栏主题 深色主题theme-dark，浅色主题theme-light
   */
  sideTheme: 'theme-light',

  /**
   * 系统布局配置
   */
  showSettings: true,

  /**
   * 是否显示顶部导航
   */
  topNav: false,

  /**
   * 是否显示 tagsView
   */
  tagsView: true,

  /**
   * 显示页签图标
   */
  tagsIcon: false,

  /**
   * 是否固定头部
   */
  fixedHeader: false,

  /**
   * 是否显示logo
   */
  sidebarLogo: true,

  /**
   * 是否显示动态标题
   */
  dynamicTitle: false,

  /**
   * 是否显示底部版权
   */
  footerVisible: false,

  /**
   * 底部版权文本内容
   */
  footerContent: 'Copyright © 2018-2025   All Rights Reserved.',

  /**
   * SSO登录配置
   */
  sso: {
    // CAS登录地址
    loginUrl: 'http://10.176.3.217/isc_sso/login',
    // 回调地址
    callbackUrl: 'http://10.176.100.15:30378/callback'
  }
}
