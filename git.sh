#!/usr/bin/env bash
git config --global color.ui auto

function push() {
	for dir in */; do
		cd "$dir" || (echo "No such dir" && exit 1)
		git init 1>/dev/null

		GIT_STATUS=$(git status)

		if [[ "$GIT_STATUS" == *"Changes not staged for commit"* ]] || [[ "$GIT_STATUS" == *"Untracked files:"* ]]; then
			echo "Repository: $dir [$(git remote get-url --push origin)]"
			git add .
			read -r -p "Commmit message: "  commit_message
			git commit -m "$commit_message"
			git push origin master 1>/dev/null
			
			if $? != 0; then
				echo "Git push failed"
				exit 1
			fi

			git log -1 --stat

			echo "--------------------------------------------------------------"
		fi

		cd ..
	done

}

function status() {
	for dir in */; do
		cd "$dir" || (echo "No such dir" && exit 1)
		git init 1>/dev/null

		if [[ $(git status) =~ "Changes to be committed"* ]]; then
			echo "$dir"
			git status -v
			echo "--------------------------------------------------------------"
		elif [[ $(git status) =~ "Your branch is ahead of"* ]]; then
			echo "$dir"
			git show --stat --oneline HEAD
			echo "cd $dir; git diff origin/master master --exit-code; cd -"
			echo "--------------------------------------------------------------"
		fi
		cd ..
	done
}

function pull() {
	for dir in */; do
		cd "$dir" || (echo "No such dir" && exit 1)
		git init 1>/dev/null && git pull --all --prune
		cd ..
	done
}


case "$1" in
	push)
		echo "Running $1"
		push
	;;
	status)
		echo "Running $1"
		status
	;;
	pull)
		echo "Running $1"
		pull
	;;
	*)	
		echo "No such command: $1"
		exit 1
	;;
esac
