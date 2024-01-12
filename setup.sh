#!/bin/sh
RES_PATH="https://github.com/rsusanto/quick-init/raw/main/res"

DIR_NAME=$1
if [ ! $DIR_NAME ]; then
	printf "Please provide a project name."
	exit
fi

# Enter the directory.
mkdir -p $DIR_NAME
cd $DIR_NAME


# Setup git.
if [ ! -d ".git" ]; then
	git init --quiet
	curl -sL "$RES_PATH/.gitconfig" >> .git/config
	curl -sL "$RES_PATH/.gitattributes" >> .gitattributes
	echo "/.gitattributes" >> ".git/info/exclude"
fi

# Setup NPM.
if [ ! -f "package.json" ]; then
	curl -sLO "$RES_PATH/package.json"
	sed -i '' "s/\"name\":.*,$/\"name\": \"$DIR_NAME\",/" package.json
	npm install --silent
	echo "/node_modules" >> ".git/info/exclude"
	echo "/package-lock.json" >> ".git/info/exclude"
fi

# Setup PHP-CS-Fixer.
if [ ! -f ".php-cs-fixer.php" ]; then
	# curl -sL https://cs.symfony.com/download/php-cs-fixer-v3.phar -o php-cs-fixer
	# chmod a+x php-cs-fixer
	curl -sLO "$RES_PATH/.php-cs-fixer.php"
	echo ".php-cs-fixer.php" >> ".git/info/exclude"
fi

# Setup Prettier.
if [ ! -f ".prettierrc.js" ]; then
	curl -sLO "$RES_PATH/.prettierignore"
	curl -sLO "$RES_PATH/.prettierrc.js"
	echo ".prettierignore" >> ".git/info/exclude"
	echo ".prettierrc.js" >> ".git/info/exclude"
fi

# Setup VSCode.
if [ ! -d ".vscode" ]; then
	mkdir .vscode
	curl -sL "$RES_PATH/.vscode/extensions.json" -o .vscode/extensions.json
	curl -sL "$RES_PATH/.vscode/settings.json" -o .vscode/settings.json
	echo ".vscode" >> ".git/info/exclude"
fi
