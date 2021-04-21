<template>
  <li :class="{ editing: isEditing }">
    <button @click="$emit('delete-me')">X</button>

    <span class="view" @dblclick="editMe"> {{ localContent }} </span>
    <input class="edit" v-model="localContent" @blur="saveMe" ref="input" />
    :
    <span class="viewer" @dblclick="editLast"> {{ localCont }} </span>
    <input class="editer" v-model="localCont" @blur="saveLast" ref="inputer" />
  </li>
</template>

<script>
export default {
  props: ["firstname", "lastname"],
  data() {
    return {
      isEditing: false,
      localContent: this.firstname,
      localCont: this.lastname,
    };
  },
  methods: {
    editMe() {
      this.isEditing = true;
      this.$nextTick(() => this.$refs.input.focus());
    },

    saveMe() {
      this.isEditing = false;
      this.$emit("save-me", this.localContent);
    },

    editLast() {
      this.isEditing = true;
      this.$nextTick(() => this.$refs.inputer.focus());
    },

    saveLast() {
      this.isEditing = false;
      this.$emit("save-last", this.localCont);
    },
  },
};
</script>


<style scoped>
.edit {
  display: none;
}
.editer {
  display: none;
}

li.editing .edit {
  display: inline;
}

li.editing .editer {
  display: inline;
}

li.editing .view {
  display: none;
}

li.editing .viewer {
  display: none;
}
</style>