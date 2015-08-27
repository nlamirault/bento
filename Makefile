# Copyright (C) 2015 Nicolas Lamirault <nicolas.lamirault@gmail.com>

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http:#www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

APP="bento"

SHELL = /bin/bash

NO_COLOR=\033[0m
OK_COLOR=\033[32;01m
ERROR_COLOR=\033[31;01m
WARN_COLOR=\033[33;01m

VERSION="0.1.0"

PACKER ?= packer

all: help

help:
	@echo -e "$(OK_COLOR)==== $(APP) [$(VERSION)] ====$(NO_COLOR)"
	@echo -e "$(WARN_COLOR)templates $(NO_COLOR)                : Display available templates"
	@echo -e "$(WARN_COLOR)validate template=xxx $(NO_COLOR)    :  Validate template"
	@echo -e "$(WARN_COLOR)virtualbox template=xxx $(NO_COLOR)  :  Build box for Virtualbox"
	@echo -e "$(WARN_COLOR)qemu template=xxx $(NO_COLOR)        :  Build box for QEmu"
	@echo -e "$(WARN_COLOR)clean              $(NO_COLOR)       :  Clean environment"


.PHONY: check
check:
	curl "https://atlas.hashicorp.com/ui/tutorial/check?access_token=$ATLAS_TOKEN"

.PHONY: templates
templates:
	@ls -1 packer|sed -e "s/\.json//g"

.PHONY: validate
validate:
	$(PACKER) validate $(template).json

.PHONY: virtualbox
virtualbox:
	$(PACKER) build -only=virtualbox-iso $(template).json

.PHONY: qemu
qemu:
	$(PACKER) build -only=qemu $(template).json

.PHONY: push
push:
	$(PACKER) push \
		--name $(ATLAS_USERNAME)/$(template) \
		-token=${ATLAS_TOKEN} \
		$(template).json

.PHONY: clean
clean:
	rm -fr output-virtualbox-iso
