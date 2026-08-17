<template>
  <section class="cta">
    <div class="cta-inner reveal" v-reveal>
      <div class="cta-glow"></div>
      <h2 class="cta-title">支持与交流</h2>
      <p class="cta-sub">如果这个项目对你有帮助，欢迎赞赏支持；也可以加入 QQ 群一起交流反馈</p>
      <div class="cta-cards">
        <div class="cta-card">
          <p class="cta-card-title">赞赏支持</p>
          <p class="cta-card-desc">扫一扫，支持作者 ☕</p>
          <img class="cta-qr" src="/iamzcr.png" alt="赞赏码" @click="preview = '/iamzcr.png'" />
        </div>
        <div class="cta-card">
          <p class="cta-card-title">QQ 交流群</p>
          <p class="cta-card-desc">加入群聊，一起交流反馈</p>
          <img class="cta-qr" src="/qrcode.jpg" alt="QQ群二维码" @click="preview = '/qrcode.jpg'" />
        </div>
      </div>
      <p class="cta-hint">👆 点击二维码可放大，扫码更清晰</p>
    </div>

    <Teleport to="body">
      <div v-if="preview" class="qr-overlay" @click.self="preview = ''">
        <div class="qr-overlay-box">
          <img class="qr-overlay-img" :src="preview" alt="二维码大图" />
          <p class="qr-overlay-tip">长按识别或使用手机扫码</p>
        </div>
      </div>
    </Teleport>
  </section>
</template>

<script setup>
import { ref } from 'vue'

const preview = ref('')
</script>

<style scoped>
.cta {
  padding: 40px 24px 96px;
}
.cta-inner {
  position: relative;
  max-width: 1080px;
  margin: 0 auto;
  text-align: center;
  padding: 72px 40px;
  border-radius: 28px;
  background: linear-gradient(135deg, #4f46e5 0%, #6366f1 45%, #06b6d4 100%);
  overflow: hidden;
  box-shadow: 0 24px 64px rgba(79, 70, 229, 0.32);
}
.cta-glow {
  position: absolute;
  width: 520px;
  height: 520px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.16);
  filter: blur(90px);
  top: -260px;
  right: -120px;
  pointer-events: none;
}
.cta-title {
  position: relative;
  color: #fff;
  font-size: 34px;
  letter-spacing: -0.01em;
  margin-bottom: 12px;
}
.cta-sub {
  position: relative;
  color: rgba(255, 255, 255, 0.85);
  font-size: 16px;
  margin: 0 0 40px;
}
.cta-cards {
  position: relative;
  display: flex;
  justify-content: center;
  gap: 32px;
  flex-wrap: wrap;
}
.cta-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  background: #fff;
  border-radius: 20px;
  padding: 24px 28px 28px;
  box-shadow: 0 12px 32px rgba(15, 23, 42, 0.18);
  min-width: 200px;
}
.cta-card-title {
  color: var(--text);
  font-size: 17px;
  font-weight: 700;
  margin: 0;
}
.cta-card-desc {
  color: var(--text-muted);
  font-size: 13px;
  margin: 0 0 4px;
}
.cta-qr {
  width: 180px;
  height: 180px;
  border-radius: 10px;
  border: 1px solid var(--border);
  object-fit: contain;
  background: #fff;
  cursor: zoom-in;
  transition: transform 0.2s var(--ease);
}
.cta-qr:hover {
  transform: scale(1.03);
}
.cta-hint {
  position: relative;
  margin-top: 24px;
  font-size: 13px;
  color: rgba(255, 255, 255, 0.75);
}
.qr-overlay {
  position: fixed;
  inset: 0;
  z-index: 1000;
  background: rgba(15, 23, 42, 0.72);
  backdrop-filter: blur(6px);
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: zoom-out;
}
.qr-overlay-box {
  background: #fff;
  border-radius: 20px;
  padding: 24px;
  box-shadow: 0 24px 64px rgba(0, 0, 0, 0.4);
  text-align: center;
  max-width: 90vw;
}
.qr-overlay-img {
  display: block;
  width: min(70vw, 360px);
  height: auto;
  border-radius: 12px;
}
.qr-overlay-tip {
  margin: 14px 0 0;
  font-size: 14px;
  color: var(--text-muted);
}
@media (max-width: 768px) {
  .cta {
    padding: 24px 20px 64px;
  }
  .cta-inner {
    padding: 52px 24px;
  }
  .cta-title {
    font-size: 26px;
  }
  .cta-cards {
    flex-direction: column;
    align-items: center;
  }
}
</style>
