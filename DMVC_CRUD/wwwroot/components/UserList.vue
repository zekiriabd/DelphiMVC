<template>
  <div>
    <h1>People List</h1>
    <table border="1">
      <thead>
        <tr>
          <th>First Name</th>
          <th>Last Name</th>
          <th>Date of Birth</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="person in people" :key="person.FirstName">
          <td>{{ person.FirstName }}</td>
          <td>{{ person.LastName }}</td>
          <td>{{ person.DOB }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
export default {
  data() {
    return {
      people: []
    };
  },
  created() {
    fetch('http://localhost:8080/api/people')
      .then(response => response.json())
      .then(data => {
        this.people = data;
      })
      .catch(error => console.error('Error fetching data:', error));
  }
};
</script>

<style scoped>

</style>
