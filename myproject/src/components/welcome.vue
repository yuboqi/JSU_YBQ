<template>
  <div>
    <el-card>
      <div class="logo">
        <img src="../assets/img/magiccreative-logo.png" alt="logo" />
        <h1>让我们为您的未来保驾护航</h1>
      </div>
      <!-- 轮播图 -->
      <el-carousel height="400px" type="card" :interval="2000">
        <el-carousel-item>
          <img src="../assets/img/rotograph01.jpg" alt />
        </el-carousel-item>
        <el-carousel-item>
          <img src="../assets/img/rotograph02.jpg" alt />
        </el-carousel-item>
        <el-carousel-item>
          <img src="../assets/img/rotograph03.jpg" alt />
        </el-carousel-item>
        <el-carousel-item>
          <img src="../assets/img/rotograph04.jpg" alt />
        </el-carousel-item>
        <el-carousel-item>
          <img src="../assets/img/rotograph05.png" alt />
        </el-carousel-item>
      </el-carousel>
      <h2 class="welcome">欢迎使用幻创远景保险公司后台管理系统！</h2>
    </el-card>
  </div>
</template>

<script>
export default {
  data() {
    return {};
  },
  methods: {}
};
</script>

<style lang="css" scoped>
.el-carousel__item img {
  height: 100%;
  width: 100%;
  object-fit: cover;
}
.welcome {
  text-align: center;
  margin: 40px 0px;
}
.logo {
  height: 60px;
  display: flex;
  align-items: center;
  margin-bottom: 20px;
  text-align: center;
}
.logo img {
  height: 100%;
}
.logo h1 {
  display: inline-block;
  margin-left: 140px;
}
</style>