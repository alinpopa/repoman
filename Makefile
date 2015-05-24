ERL ?= erl
APP := repoman
REBAR ?= ./rebar

.PHONY: deps

all: deps compile eunit

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

node: distclean all
	cd rel/ && ../$(REBAR) generate

docs:
	$(ERL) -noshell -run edoc_run application '$(APP)' '"."' '[]'
