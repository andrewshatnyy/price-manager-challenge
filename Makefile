.PHONY : test

test: test-e2e test-unit

test-e2e:
	docker run -ti --rm -v \
	$(shell pwd):/srv -w /srv \
	ruby:2.3 test/*.sh

test-unit:
	docker run -ti --rm -v \
	$(shell pwd):/srv -w /srv \
	ruby:2.3 ruby -Ilib:test test/runner.rb

shell:
	docker run -ti --rm -v \
	$(shell pwd):/srv -w /srv \
	ruby:2.3 bash
