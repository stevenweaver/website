import Tablesort from "tablesort";

export default ({ Vue, options, router, siteData }) => {
  router.afterEach(() => {
    Vue.nextTick(() => {
      const tables = document.querySelectorAll("table");
      tables.forEach((table) => {
        new Tablesort(table);
      });
    });
  });
};
