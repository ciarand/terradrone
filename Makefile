ANSIBLE=/usr/bin/env ansible-playbook
OPTS?=

site:
	PLAYBOOK=site.yml make install

debug:
	PLAYBOOK=site.yml OPTS=-vvvv make install

bootstrap:
	PLAYBOOK=bootstrap.yml make install

install:
	${ANSIBLE} ${PLAYBOOK} ${OPTS}

clean:
	rm -rf terraform.tfstate*

apply:
	terraform apply -input=0

.PHONY: site debug bootstrap install clean apply
