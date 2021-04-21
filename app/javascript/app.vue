<template>
  <div id="app">
    <ul v-if="!myObject">
      <transition-group name="list" tag="p">
        <List
          v-for="(entry, index) in entryData"
          :key="entry.id"
          :firstname="entry.firstname"
          :lastname="entry.lastname"
          @delete-me="clearEntry(index)"
          @save-me="updateEntry(index, $event)"
          @save-last="updateEntry(index, $event)"
        >
          >
        </List>
      </transition-group>
    </ul>

    <input placeholder="firstname" type="text" v-model="firstname" /> <br />
    <input placeholder="lastname" type="text" v-model="lastname" /> <br />
    <button @click="savePerson" v-on:click="add">Add</button>
    <button @click="clearAll" v-on:click="remove">Clear</button>
  </div>
</template>

<script>
import axios from "axios";
import List from "./packs/components/List";

const API_URL = "/api/people";

export default {
  data() {
    return {
      firstname: "",
      lastname: "",
      entryData: [],
      myObject: null,
    };
  },
  methods: {
    savePerson() {
      axios
        .post(API_URL, {
          firstname: this.firstname,
          lastname: this.lastname,
        })
        .then((response) => this.loadEntries())
        .catch((e) => console.log(e));
      this.firstname = "";
      this.lastname = "";
    },

    deleteEntry(id) {
      // delete one entry on the server by id
      return axios.delete(API_URL + "/" + id);
    },

    clearEntry(i) {
      // delete the i-th entry from the server and the client
      // this.deleteEntry(this.entryData[i].id);
      let id = this.entryData[i].id;
      axios
        .delete(API_URL + "/" + id)
        .then((response) => this.loadEntries())
        .catch((e) => console.log(e));
    },

    updateEntry(i, firstname) {
      let entry = this.entryData[i];
      entry.firstname = firstname;
      axios
        .put(API_URL + "/" + entry.id, entry)
        .then((response) => this.loadEntries())
        .catch((e) => console.log(e));
    },

    deleteOneByOne() {
      // delete all Entries in this.tempData one by one from the server
      if (this.tempData.length > 0) {
        this.deleteEntry(this.tempData[0].id)
          .then((r) => axios.get(API_URL))
          .then((response) => {
            this.tempData = response.data;
            this.deleteOneByOne(); // recursion
          });
      }
    },

    clearAll() {
      this.tempData = this.entryData;
      this.deleteOneByOne();
      this.entryData = [];
    },

    loadEntries() {
      axios
        .get(API_URL)
        .then((response) => {
          this.entryData = response.data;
        })
        .catch((e) => console.log(e));
    },
  },

  mounted() {
    this.loadEntries();
  },
  components: {
    List,
  },
};
</script>

<style scoped>
ul {
  display: flex;
}

p {
  font-size: 2em;
  text-align: center;
}

li {
  list-style: none;
}

.list-item {
  display: inline-block;
  margin-right: 10px;
}
.list-enter-active,
.list-leave-active {
  transition: all 1s;
}
.list-enter, .list-leave-to /* .list-leave-active below version 2.1.8 */ {
  opacity: 0;
  transform: translateY(30px);
}
</style>
