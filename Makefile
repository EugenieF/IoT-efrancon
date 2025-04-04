# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: llalba <llalba@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2013/11/18 13:37:42 by llalba            #+#    #+#              #
#    Updated: 2025/04/04 13:11:35 by llalba           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all: switch push

switch:
	@CURRENT_VERS=$$(cat deploy.yaml | grep "image:" | rev | cut -c1); \
	NEW_VERS=$$([ "$$CURRENT_VERS" -eq 1 ] && echo 2 || echo 1); \
	echo "Switching to tag $$NEW_VERS"; \
	sed -i "s/wil42\/playground\:v$$CURRENT_VERS/wil42\/playground\:v$$NEW_VERS/g" deploy.yaml; \
	export VERSION=$$NEW_VERS; \
	echo "Version switched to $$NEW_VERS."

push:
	@echo "Pushing version $$VERSION"
	@git add .
	@git commit -m "New version: $$VERSION"
	@git push origin main
	@echo "Changes pushed with version $$VERSION."

.PHONY: all switch push
