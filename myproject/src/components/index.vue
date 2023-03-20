<template>
  <div>
    <el-menu default-active="1" class="el-menu-demo" mode="horizontal" @select="handleClick">
      <el-menu-item index="/profile">个人中心</el-menu-item>
      <el-menu-item index="/bxcp">购买保险</el-menu-item>
      <el-menu-item index="/wddd">我的订单</el-menu-item>
      <el-submenu index="2-4">
        <template slot="title">索赔</template>
        <el-menu-item index="/f-sqsp">申请索赔</el-menu-item>
        <el-menu-item index="/f-wdsq">我的索赔</el-menu-item>
      </el-submenu>
      <el-menu-item index="/login">退出登录</el-menu-item>
      <el-menu-item index="/home" v-show="showMenu">后台管理
      </el-menu-item>
    </el-menu>
    <router-view/>
  </div>
</template>
<script>
export default {
  data() {
    return {
      showMenu: false
    }
  },
  mounted() {
    const ss = sessionStorage.getItem("userData");
    if (ss) {
      JSON.parse(ss).role === 0 || JSON.parse(ss).role === 1 ? this.showMenu = true : this.showMenu = false;
    }
  },
  methods: {
    handleClick(key) {
      window.location.href = key;
    }
  }
}

</script>
