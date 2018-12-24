<template>
  <div id="app" align="center">
		<img src="./assets/logo.png">
    <block_civilization/>
  </div>
</template>

<script>
import block_civilization from './components/block_civilization'

export default {
  name: 'App',
  components: {
    block_civilization
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
}
</style>
