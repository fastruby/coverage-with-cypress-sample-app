describe("User creation", function () {
  beforeEach(() => {
    cy.app("clean"); // have a look at e2e/app_commands/clean.rb
  });

  it("requires name and lastname", function () {
    cy.visit("/users/new");
    cy.get("form").submit();
    cy.get("li").contains("Name can't be blank");
    cy.get("li").contains("Lastname can't be blank");
  });
});
