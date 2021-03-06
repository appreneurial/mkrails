function mkrails {
	MKRAILS_APP_NAME="."
	MKRAILS_DATABASE_PROVIDER="postgresql"
	MKRAILS_RAILS_VERSION="4.1.6"
	MKRAILS_RECIPES="bdd,haml,bootstrap,font-awesome,simple_form,devise,heroku,unicorn,better_errors,quiet_assets"
	MKRAILS_RUBY_VERSION="2.1.2"
	MKRAILS_SITE_OWNER="Jason Green"
	MKRAILS_SITE_OWNER_URL="http://www.appreneurial.co"
	MKRAILS_SOURCE="https://raw.githubusercontent.com/appreneurial/mkrails/master"

	while [[ "$1" != "" ]]; do
		PARAM=`echo $1 | awk -F= '{print $1}'`
		VALUE=`echo $1 | awk -F= '{print $2}'`

		case $PARAM in
			--app-name)
				MKRAILS_APP_NAME=$VALUE
				;;
			--database-provider)
				MKRAILS_DATABASE_PROVIDER=$VALUE
				;;
			--rails-version)
				MKRAILS_RAILS_VERSION=$VALUE
				;;
			--recipes)
				MKRAILS_RECIPES=$VALUE
				;;
			--ruby-version)
				MKRAILS_RUBY_VERSION=$VALUE
				;;
			--site-owner)
				MKRAILS_SITE_OWNER=$VALUE
				;;
			--site-owner-url)
				MKRAILS_SITE_OWNER_URL=$VALUE
				;;
			--source)
				MKRAILS_SOURCE=$VALUE
				;;
		esac

		shift
	done

	export MKRAILS_APP_NAME
	export MKRAILS_DATABASE_PROVIDER
	export MKRAILS_RAILS_VERSION
	export MKRAILS_RECIPES
	export MKRAILS_RUBY_VERSION
	export MKRAILS_SITE_OWNER
	export MKRAILS_SITE_OWNER_URL
	export MKRAILS_SOURCE

	if [[ "$MKRAILS_APP_NAME" != "." ]]; then
		mkdir $MKRAILS_APP_NAME
		cd $MKRAILS_APP_NAME
	fi
	rvm use ruby-$MKRAILS_RUBY_VERSION@`basename $PWD` --create --ruby-version
	gem install rails --version=$MKRAILS_RAILS_VERSION
	rails new . --database=$MKRAILS_DATABASE_PROVIDER --force -m $MKRAILS_SOURCE/mkrails.rb

	unset MKRAILS_APP_NAME
	unset MKRAILS_DATABASE_PROVIDER
	unset MKRAILS_RAILS_VERSION
	unset MKRAILS_RECIPES
	unset MKRAILS_RUBY_VERSION
	unset MKRAILS_SITE_OWNER
	unset MKRAILS_SITE_OWNER_URL
	unset MKRAILS_SOURCE
}