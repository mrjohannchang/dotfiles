SHELL = bash


.PHONY: default clean uninstall install


default:

	@git submodule update --init --recursive --remote
	@git submodule foreach -q --recursive 'branch="$$(git config -f \
		"$$toplevel"/.gitmodules submodule."$$name".branch)"; git checkout "$$branch"'


clean:

	@git submodule deinit -f .
	@git clean -xdf > /dev/null 2>&1
	@git clean -xdfn | while read line; do \
		rm -rf "$${line#Would skip repository }"; \
	done


uninstall:

	@if [ -L ~/.bash_completion.d ]; then \
		unlink ~/.bash_completion.d; \
		echo ".bash_completion.d uninstalled."; \
	fi

	@if [ -L ~/.bashrc ]; then \
		unlink ~/.bashrc; \
		echo ".bashrc uninstalled."; \
	fi

	@if [ -L ~/.pentadactylrc ]; then \
		unlink ~/.pentadactylrc; \
		echo ".pentadactylrc uninstalled."; \
	fi

	@if [ -L ~/.profile ]; then \
		unlink ~/.profile; \
		echo ".profile uninstalled."; \
	fi

	@if [ -L ~/.tmux.conf ]; then \
		unlink ~/.tmux.conf; \
		echo ".tmux.conf uninstalled."; \
	fi

	@if [ -L ~/.vim ]; then \
		unlink ~/.vim; \
		echo ".vim uninstalled."; \
	fi

	@if [ -L ~/.vimrc ]; then \
		unlink ~/.vimrc; \
		echo ".vimrc uninstalled."; \
	fi

	@if [ -L ~/.vimperatorrc ]; then \
		unlink ~/.vimperatorrc; \
		echo ".vimperatorrc uninstalled."; \
	fi

	@if [[ "$${OSTYPE,,}" == linux* ]]; then \
		if [ -L ~/.dircolorsdb ]; then \
			unlink ~/.dircolorsdb; \
			echo "dircolorsdb uninstalled."; \
		fi; \
		\
		if [ -L ~/.fonts/PowerlineSymbols.otf ] || \
			[ -L ~/.config/fontconfig/conf.d/10-powerline-symbols.conf ]; then \
			if [ -L ~/.fonts/PowerlineSymbols.otf ]; then \
				unlink ~/.fonts/PowerlineSymbols.otf; \
			fi; \
			if [ -L ~/.config/fontconfig/conf.d/10-powerline-symbols.conf ]; then \
				unlink ~/.config/fontconfig/conf.d/10-powerline-symbols.conf; \
			fi; \
			echo "Powerline's font uninstalled."; \
		fi; \
		\
		if [ -L ~/.config/fontconfig/conf.d/20-noto-cjk.conf ]; then \
			unlink ~/.config/fontconfig/conf.d/20-noto-cjk.conf; \
			echo "Noto Sans' fontconfig uninstalled."; \
		fi; \
	fi

	@echo "uninstallation completed."


install: uninstall

	@if [ -e ~/.bash_completion.d ] && [ ! -L ~/.bash_completion.d ]; then \
		rm -rf ~/.bash_completion.d.bak; \
		mv ~/.bash_completion.d ~/.bash_completion.d.bak; \
	fi
	@ln -fs "$$PWD"/.bash_completion.d ~/.bash_completion.d
	@echo ".bash_completion.d installed."

	@if [ -e ~/.bashrc ] && [ ! -L ~/.bashrc ]; then \
		rm -rf ~/.bashrc.bak; \
		mv ~/.bashrc ~/.bashrc.bak; \
	fi
	@ln -fs "$$PWD"/.bashrc ~/.bashrc
	@echo ".bashrc installed."

	@if [ -e ~/.pentadactylrc ] && [ ! -L ~/.pentadactylrc ]; then \
		rm -rf ~/.pentadactylrc.bak; \
		mv ~/.pentadactylrc ~/.pentadactylrc.bak; \
	fi
	@ln -fs "$$PWD"/.pentadactylrc ~/.pentadactylrc
	@echo ".pentadactylrc installed."

	@if [ -e ~/.profile ] && [ ! -L ~/.profile ]; then \
		rm -rf ~/.profile.bak; \
		mv ~/.profile ~/.profile.bak; \
	fi
	@ln -fs "$$PWD"/.profile ~/.profile
	@echo ".profile installed."

	@if [ -e ~/.tmux.conf ] && [ ! -L ~/.tmux.conf ]; then \
		rm -rf ~/.tmux.conf.bak; \
		mv ~/.tmux.conf ~/.tmux.conf.bak; \
	fi
	@ln -fs "$$PWD"/.tmux.conf ~/.tmux.conf
	@echo ".tmux.conf installed."

	@if [ -e ~/.vim ] && [ ! -L ~/.vim ]; then \
		rm -rf ~/.vim.bak; \
		mv ~/.vim ~/.vim.bak; \
	fi
	@ln -fs "$$PWD"/.vim ~/.vim
	@echo ".vim installed."

	@if [ -e ~/.vimrc ] && [ ! -L ~/.vimrc ]; then \
		rm -rf ~/.vimrc.bak; \
		mv ~/.vimrc ~/.vimrc.bak; \
	fi
	@ln -fs "$$PWD"/.vimrc ~/.vimrc
	@echo ".vimrc installed."

	@if [ -e ~/.vimperatorrc ] && [ ! -L ~/.vimperatorrc ]; then \
		rm -rf ~/.vimperatorrc.bak; \
		mv ~/.vimperatorrc ~/.vimperatorrc.bak; \
	fi
	@ln -fs "$$PWD"/.vimperatorrc ~/.vimperatorrc
	@echo ".vimperatorrc installed."

	@if [[ "$${OSTYPE,,}" == linux* ]]; then \
		echo -n "Install Solaried dircolorsdb [y/N]? " \
		read ans; \
		if [ "$${ans,,}" = "y" ]; then \
			if [ -e ~/.dircolorsdb ] && [ ! -L ~/.dircolorsdb ]; then \
				rm -rf ~/.dircolorsdb.bak; \
				mv ~/.dircolorsdb ~/.dircolorsdb.bak; \
			fi; \
			ln -fs "$$PWD"/bundle/dircolors-solarized/dircolors.ansi-light \
				~/.dircolorsdb; \
			echo ".dircolorsdb installed."; \
		fi; \
		\
		echo "Installing Solarized color scheme to current Gnome Terminal profile," \
		echo -n "this cannot be undone. Proceed to install [y/N]? " \
		read ans; \
		if [ "$${ans,,}" = "y" ]; then \
			bundle/gnome-terminal-colors-solarized/set_light.sh; \
			echo "Gnome Terminal is now solarized."; \
		fi; \
		\
		if [ ! -d ~/.fonts ]; then \
			rm -rf ~/.fonts; \
			mkdir ~/.fonts; \
		fi; \
		\
		if [ ! -d ~/.config/fontconfig/conf.d ]; then \
			rm -rf ~/.config/fontconfig/conf.d; \
			mkdir -p ~/.config/fontconfig/conf.d; \
		fi; \
		ln -fs "$$PWD"/.fonts/PowerlineSymbols.otf ~/.fonts; \
		ln -fs "$$PWD"/.config/fontconfig/conf.d/10-powerline-symbols.conf \
			~/.config/fontconfig/conf.d; \
		echo "Powerline's font installed."; \
		\
		ln -fs "$$PWD"/.config/fontconfig/conf.d/20-noto-cjk.conf \
			~/.config/fontconfig/conf.d; \
		echo "Noto Sans' fontconfig installed."; \
	fi

	@echo "installation completed."
