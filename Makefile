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

GREEN=\033[0;32m
YELLOW=\033[0;33m
RESET=\033[0m

all: switch_n_push

switch_n_push:
	@CURRENT_VERS=$$(cat deployment.yaml | grep "image:" | rev | cut -c1); \
	NEW_VERS=$$([ "$$CURRENT_VERS" -eq 1 ] && echo 2 || echo 1); \
	echo "$(YELLOW)Switching from v$$CURRENT_VERS to v$$NEW_VERS...$(RESET)"; \
	if [ -f deployment.yaml ]; then \
		if [[ "$$(uname)" == "Darwin" ]]; then \
			sed -i "" "s/wil42\/playground\:v$$CURRENT_VERS/wil42\/playground\:v$$NEW_VERS/g" deployment.yaml; \
		else \
			sed -i "s/wil42\/playground\:v$$CURRENT_VERS/wil42\/playground\:v$$NEW_VERS/g" deployment.yaml; \
		fi; \
	fi; \
	echo "$(YELLOW)Pushing new version to Git...$(RESET)"; \
	git add .; \
	git commit -m "New version: $$NEW_VERS"; \
	git push origin main; \
	echo "$(GREEN)Changes pushed with version $$NEW_VERS$(RESET)"

PHONY: all switch_n_push
