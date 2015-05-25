ERL ?= erl
APP := repoman
REBAR ?= $(CURDIR)/rebar

.PHONY: deps

all: distclean deps compile eunit node

compile:
	$(REBAR) compile

eunit:
	$(REBAR) eunit

deps:
	$(REBAR) get-deps

clean:
	rm -rf rel/$(APP)
	$(REBAR) clean

distclean: clean
	$(REBAR) delete-deps

start: all
	$(ERL) -pa $(PWD)/ebin $(PWD)/deps/*/ebin -boot start_sasl -s repoman

node:
	cd rel/ && $(REBAR) generate

docs:
	$(ERL) -noshell -run edoc_run application '$(APP)' '"."' '[]'
