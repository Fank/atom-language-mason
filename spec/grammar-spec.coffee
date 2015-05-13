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
      expect(lines[0][0]).toEqual value: "<%", scopes: ["text.html.mason", "source.mason.substitution", "keyword.control"]
      expect(lines[0][3]).toEqual value: "%>", scopes: ["text.html.mason", "source.mason.substitution", "keyword.control"]
      expect(lines[1][0]).toEqual value: "<%", scopes: ["text.html.mason", "source.mason.substitution", "keyword.control"]
      expect(lines[1][3]).toEqual value: "%>", scopes: ["text.html.mason", "source.mason.substitution", "keyword.control"]
      expect(lines[2][0]).toEqual value: "<%", scopes: ["text.html.mason", "source.mason.substitution", "keyword.control"]
      expect(lines[2][3]).toEqual value: "%>", scopes: ["text.html.mason", "source.mason.substitution", "keyword.control"]

  describe "when a init block tokenizes", ->
    it "works as expected", ->
      lines = grammar.tokenizeLines("""<%init>
        ###
        </%init>
      """)
      expect(lines[0][0]).toEqual value: "<%", scopes: ["text.html.mason", "source.perl.mason.block", "punctuation.section.embedded.perl.mason"]
      expect(lines[0][1]).toEqual value: "init", scopes: ["text.html.mason", "source.perl.mason.block", "punctuation.section.embedded.perl.mason", "keyword.control"]
      expect(lines[0][2]).toEqual value: ">", scopes: ["text.html.mason", "source.perl.mason.block", "punctuation.section.embedded.perl.mason"]
      expect(lines[1][0]).toEqual value: "###", scopes: ["text.html.mason", "source.perl.mason.block"]
      expect(lines[2][0]).toEqual value: "</%", scopes: ["text.html.mason", "source.perl.mason.block", "punctuation.section.embedded.perl.mason"]
      expect(lines[2][1]).toEqual value: "init", scopes: ["text.html.mason", "source.perl.mason.block", "punctuation.section.embedded.perl.mason", "keyword.control"]
      expect(lines[2][2]).toEqual value: ">", scopes: ["text.html.mason", "source.perl.mason.block", "punctuation.section.embedded.perl.mason"]

  describe "when a perl block tokenizes", ->
    it "works as expected", ->
      lines = grammar.tokenizeLines("""<%perl>
        ###
        </%perl>
      """)
      expect(lines[0][0]).toEqual value: "<%", scopes: ["text.html.mason", "source.perl.mason.block", "punctuation.section.embedded.perl.mason"]
      expect(lines[0][1]).toEqual value: "perl", scopes: ["text.html.mason", "source.perl.mason.block", "punctuation.section.embedded.perl.mason", "keyword.control"]
      expect(lines[0][2]).toEqual value: ">", scopes: ["text.html.mason", "source.perl.mason.block", "punctuation.section.embedded.perl.mason"]
      expect(lines[1][0]).toEqual value: "###", scopes: ["text.html.mason", "source.perl.mason.block"]
      expect(lines[2][0]).toEqual value: "</%", scopes: ["text.html.mason", "source.perl.mason.block", "punctuation.section.embedded.perl.mason"]
      expect(lines[2][1]).toEqual value: "perl", scopes: ["text.html.mason", "source.perl.mason.block", "punctuation.section.embedded.perl.mason", "keyword.control"]
      expect(lines[2][2]).toEqual value: ">", scopes: ["text.html.mason", "source.perl.mason.block", "punctuation.section.embedded.perl.mason"]
