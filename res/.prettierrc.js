module.exports = {
	arrowParens: 'avoid',
	bracketSpacing: true,
	endOfLine: 'lf',
	printWidth: 100,
	semi: true,
	singleQuote: true,
	tabWidth: 4,
	trailingComma: 'none',
	useTabs: true,

	overrides: [
		{
			files: '*.json',
			options: {
				tabWidth: 2,
				useTabs: false
			}
		}
	]
};
