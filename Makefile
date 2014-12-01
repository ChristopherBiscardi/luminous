#
# run: doesn't have a target
# dockerfile: should be rebuilt regardless of changes in dockerfile
# since docker can take care of caching build steps
#

.PHONY : run dockerfile

#
# Commands for building a dockerfile in which to develop PureScript
# based applications/libraries
#

dockerfile:
	docker build -t biscarch/luminous .

run:
	docker run -itv `pwd`:/files biscarch/luminous bash

#
# The below commands are meant to be run in a container run from the
# above image `biscarch/luminous`.
# 

dev: src/
	mkdir -p node_modules && psc-make src/Data/Luminous.purs --output node_modules/

dist: src/
	mkdir -p node_modules && psc-make src/Data/Luminous.purs --output dist/

outside-dev: src/
	docker run -itv `pwd`:/files biscarch/luminous /bin/sh -c "cd /files && make dev"
