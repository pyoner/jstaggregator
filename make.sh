#make standalone FlexTokenizer.js

STANDALONE=js/FlexTokenizer.js

sed -i '/function FlexTokenizer(input, progress) {/q' $STANDALONE;
echo '' >> $STANDALONE;
sed '/function ClassicTokenizerImpl(zzReader)  {/,$!d' jflex/ClassicTokenizerImpl.js | sed 's!^!\t!' >> $STANDALONE;
echo '' >> $STANDALONE;
sed '/function StringReader(input) {/,$!d' js/StringReader.js | sed 's!^!\t!' >> $STANDALONE;
echo '' >> $STANDALONE;
echo 'var impl = new ClassicTokenizerImpl(new StringReader(input));' | sed 's!^!\t!' >> $STANDALONE;
echo '' >> $STANDALONE;
sed '/function Token(term, start, end) {/,$!d' js/Token.js | sed 's!^!\t!' >> $STANDALONE;
echo '' >> $STANDALONE;
echo 'this.incrementToken = function() {' | sed 's!^!\t!' >> $STANDALONE;
echo '' >> $STANDALONE;
echo 'var token = impl.getNextToken();' | sed 's!^!\t\t!' >> $STANDALONE;
echo 'if (token === null) return null;' | sed 's!^!\t\t!' >> $STANDALONE;
echo '' >> $STANDALONE;
echo 'var inputLength = input.length;' | sed 's!^!\t!' >> $STANDALONE;
echo '' >> $STANDALONE;
echo 'if (progress) {' | sed 's!^!\t\t!' >> $STANDALONE;
echo 'progress(impl.yychar(), inputLength);' | sed 's!^!\t\t\t!' >> $STANDALONE;
echo '}' | sed 's!^!\t\t!' >> $STANDALONE;
echo '' >> $STANDALONE;
echo 'var content = impl.yytext();' | sed 's!^!\t\t!' >> $STANDALONE;
echo 'return new Token(content, impl.yychar(), impl.yychar() + content.length);' | sed 's!^!\t\t!' >> $STANDALONE;
echo '}' | sed 's!^!\t!' >> $STANDALONE;
echo '}' >> $STANDALONE;