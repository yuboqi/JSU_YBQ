<template>
  <el-container class="home-container">
    <!-- 头部区域 -->
    <el-header>
      <div class="home-logo">
        <img src="../assets/img/hkLog.jpg" alt @click="toHomePage"/>
        <span>幻创远景保险公司客户信息管理系统</span>
      </div>
      <el-button type="warning" @click="logout" size="mini" plain>退出</el-button>
    </el-header>
    <!-- 主体区域 -->
    <el-container>
      <!-- 侧边栏 -->
      <el-aside :width="isCollapse ? '64px' : '200px'">
        <!-- 点击折叠侧边栏菜单 -->
        <el-tooltip effect="light" content="折叠/展开" placement="bottom-end" :enterable="false">
          <div class="toggle-button" @click="toggleCollapse">|||</div>
        </el-tooltip>
        <!-- 侧边栏菜单区域 -->
        <el-menu
          background-color="#333744"
          text-color="#fff"
          active-text-color="#409eff"
          unique-opened
          :collapse="isCollapse"
          :collapse-transition="false"
          router
          :default-active="activePath"
        >
          <!-- 一级菜单 -->
          <el-submenu :index="item.id+''" v-for="item in $store.state.routerlist" :key="item.id">
            <!-- 一级菜单模板 -->
            <template slot="title">
              <!-- 图标 -->
              <i :class="iconobj[item.id]"></i>
              <!-- 文本 -->
              <span>{{item.authName}}</span>
            </template>
            <!-- 二级菜单 -->
            <el-menu-item
              :index="'/'+subItem.path"
              v-for="subItem in item.children"
              :key="subItem.id"
              @click="saveNavState('/'+subItem.path)"
            >
              <template slot="title">
                <!-- 图标 -->
                <i class="el-icon-menu"></i>
                <!-- 文本 -->
                <span>{{subItem.authName}}</span>
              </template>
            </el-menu-item>
          </el-submenu>
        </el-menu>
      </el-aside>
      <!-- 内容主体区域 -->
      <el-main>
        <router-view></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
export default {
  data() {
    return {
      // 侧边栏导航
      menulist:[],
      iconobj: {
        "1": "iconfont iconren",
        "2": "iconfont iconicon-",
        "3": "iconfont iconsushe",
        "4": "iconfont iconic_opt_feature",
        "5": "iconfont iconxuesheng",
        "6": "iconfont iconhouqinwuzi",
        "7": "iconfont iconiconfontshenghuojiaofei",
        "8": "iconfont icontongji"
      },
      //   是否折叠
      isCollapse: false,
      //   被激活的连接地址
      activePath: ""
    };
  },
  created() {
      this.activePath = window.sessionStorage.getItem('activePath');
      // 从 vuex 中取到路由表 设置给 menulist
      this.menulist = this.$store.state.routerlist;
  },
  methods: {
    // 退出按钮
    logout() {
      // window.sessionStorage.clear();
      this.$router.push("/login");
      // 删除sessionStorage中保存的值
      sessionStorage.clear ()
    },
    // 点击折叠与展开侧边栏菜单
    toggleCollapse() {
      this.isCollapse = !this.isCollapse;
    },
    // 保存链接的激活状态
    saveNavState(activePath) {
      window.sessionStorage.setItem("activePath", activePath);
      this.activePath = activePath;
    },
    //路由跳转到首页
    toHomePage(){
      this.$router.push("/bxcp");
    }
  }
};
</script>

<style lang="css" scoped>
.home-container {
  height: 100%;
}
.el-header {
  background-color: #23262e;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-left: 0;
}
.home-logo {
  display: flex;
  align-items: center;
  cursor: pointer;
}
.home-logo img {
  width: 6.2%;
}
.home-logo span {
  color: white;
  font-size: 20px;
  margin-left: 15px;
}
.el-aside {
  background-color: #393d49;
}
.el-main {
  background-color: #eaedf1;
}
.el-menu {
  border-right: none;
}
.iconfont {
  margin-right: 15px;
}
.toggle-button {
  background: #4a5064;
  color: white;
  text-align: center;
  letter-spacing: 0.2em;
  cursor: pointer;
  font-size: 10px;
  line-height: 24px;
}
</style>