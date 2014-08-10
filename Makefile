SHELL = /bin/bash


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

	@if [ -L ~/.dircolorsdb ]; then \
		unlink ~/.dircolorsdb; \
		echo "dircolorsdb uninstalled."; \
	fi

	@if [ -L ~/.fonts.conf ]; then \
		unlink ~/.fonts.conf; \
		echo ".fonts.conf uninstalled."; \
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

	@if [ -L ~/.fonts/PowerlineSymbols.otf ] \
		|| [ -L ~/.config/fontconfig/conf.d/10-powerline-symbols.conf ]; then \
		if [ -L ~/.fonts/PowerlineSymbols.otf ]; then \
			unlink ~/.fonts/PowerlineSymbols.otf; \
		fi; \
		if [ -L ~/.config/fontconfig/conf.d/10-powerline-symbols.conf ]; then \
			unlink ~/.config/fontconfig/conf.d/10-powerline-symbols.conf; \
		fi; \
		echo "Powerline uninstalled."; \
	fi
	@if [ -L ~/.config/powerline/config.json ]; then \
		unlink ~/.config/powerline/config.json; \
	fi

	@echo Done.


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

	@echo -n "Install Solaried dircolorsdb [y/N]? "
	@read ans; \
	if [ "$${ans,,}" = "y" ]; then \
		if [ -e ~/.dircolorsdb ] && [ ! -L ~/.dircolorsdb ]; then \
			rm -rf ~/.dircolorsdb.bak; \
			mv ~/.dircolorsdb ~/.dircolorsdb.bak; \
		fi; \
		ln -fs "$$PWD"/bundle/dircolors-solarized/dircolors.ansi-light \
			~/.dircolorsdb; \
		echo ".dircolorsdb installed."; \
	fi

	@echo "Installing Solarized color scheme to current Gnome Terminal profile,"
	@echo -n "this cannot be undone. Proceed to install [y/N]? "
	@read ans; \
	if [ "$${ans,,}" = "y" ]; then \
		bundle/gnome-terminal-colors-solarized/set_light.sh; \
		echo "Gnome Terminal is now solarized."; \
	fi

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

	@if [ -e ~/.fonts.conf ] && [ ! -L ~/.fonts.conf ]; then \
		rm -rf ~/.fonts.conf.bak; \
		mv ~/.fonts.conf ~/.fonts.conf.bak; \
	fi
	@ln -fs "$$PWD"/.fonts.conf ~/.fonts.conf
	@echo ".fonts.conf installed."

	@if [ ! -d ~/.fonts ]; then \
		rm -rf ~/.fonts; \
		mkdir ~/.fonts; \
	fi
	@if [ ! -d ~/.config/fontconfig/conf.d ]; then \
		rm -rf ~/.config/fontconfig/conf.d; \
		mkdir -p ~/.config/fontconfig/conf.d; \
	fi
	@ln -fs "$$PWD"/.vim/bundle/powerline/font/PowerlineSymbols.otf ~/.fonts
	@ln -fs "$$PWD"/.vim/bundle/powerline/font/10-powerline-symbols.conf \
		~/.config/fontconfig/conf.d
	@if [ ! -d ~/.config/powerline ]; then \
		rm -rf ~/.config/powerline; \
		mkdir -p ~/.config/powerline; \
	fi
	@ln -fs "$$PWD"/.config/powerline/config.json ~/.config/powerline
	@echo "Powerline installed."

	@echo Done.
