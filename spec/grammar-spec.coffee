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

  describe "when a substitution tokenizes", ->
    it "works as expected", ->
      lines = grammar.tokenizeLines("""<% $testVariable %>
        <% $ENV{TEST} %>
        <% $hash->{test} %>
      """)
      expect(lines[0][0]).toEqual value: "<%", scopes: ['text.html.mason', 'source.mason.substitution', 'keyword.control']
      expect(lines[0][3]).toEqual value: "%>", scopes: ['text.html.mason', 'source.mason.substitution', 'keyword.control']
      expect(lines[1][0]).toEqual value: "<%", scopes: ['text.html.mason', 'source.mason.substitution', 'keyword.control']
      expect(lines[1][3]).toEqual value: "%>", scopes: ['text.html.mason', 'source.mason.substitution', 'keyword.control']
      expect(lines[2][0]).toEqual value: "<%", scopes: ['text.html.mason', 'source.mason.substitution', 'keyword.control']
      expect(lines[2][3]).toEqual value: "%>", scopes: ['text.html.mason', 'source.mason.substitution', 'keyword.control']
