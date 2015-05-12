describe "perl grammar", ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("language-mason")

    runs ->
      grammar = atom.grammars.grammarForScopeName("text.html.mason")

  it "parses the grammar", ->
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe "text.html.mason"
