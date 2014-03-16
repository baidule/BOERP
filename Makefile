TESTS = test/*.test.coffee
COMPILERS = coffee:coffee-script/register
REPORTER = spec
TIMEOUT = 10000
JSCOVERAGE = ./node_modules/jscover/bin/jscover

install:
	@npm install

test:
	@NODE_ENV=test ./node_modules/mocha/bin/mocha \
    --compilers $(COMPILERS)\
    --reporter $(REPORTER) \
    --timeout $(TIMEOUT) \
    --require supertest\
    $(TESTS)

test-cov: lib-cov
  @URLRAR_COV=1 $(MAKE) test
  @URLRAR_COV=1 $(MAKE) test REPORTER=html-cov > coverage.html

lib-cov:
	@rm -rf $@
	@$(JSCOVERAGE) lib $@

.PHONY: install test test-cov lib-cov