import Tablesort from "tablesort";

export default ({ Vue, options, router, siteData }) => {
  // Check if we are in the browser environment
  if (typeof window !== "undefined") {
    router.afterEach(() => {
      Vue.nextTick(() => {
        const tables = document.querySelectorAll("table");
        tables.forEach((table) => {
          new Tablesort(table);
        });
      });
    });
  }
};
