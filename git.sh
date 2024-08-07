#!/bin/bash

# documentation : https://git-scm.com/docs/

#?--------------------------------------- Installation------------------------------------------------------ #
sudo apt update
sudo apt install git -y
git --version

# Installation on RPM based
sudo dnf install git-all #or 
sudo yum install git-all

#?------------------------------------------Getting help-----------------------------------------------------#
git help #Get the help and command palatte
git show #show various types of objects

git help <command> #view additional help on each command
# for this you must install the git man pages using following
sudo apt-get install git-man

#?------------------------------------------Git start-up------------------------------------------------------#
git init #!Init a Git Repository, this will create the directory structure .git hidden directory
git status #Check the branches , Commits and Untracked files
git add myFile.json #Stage a file for commit ready
git commit -m "Added first story" #commit all staged files with a useful comment
git commit -am "My commit" # -a, --all option tells Git to automatically stage files that have been modified and deleted. But new files you have not told Git about are not affected.

# Before commit you need to introduce git who you are to show the author
git config user.name "sarah" #add a user for commit, so all commits are recorded in the name of the author
git config user.email "sarah@example.com"  #add user's email address who perform commit

git config --global user.name "Jumaan Rimzy"
git config --global user.email "jumaanr@outlook.com"

git config --list #shows the current values
git commit #when you open this command without any options , opens a text editor - here you provide a commit message 
git add .  #stage all the files in working area
git add *.txt #pattern base staging , where you add the txt files only

#?----------------------------------------Restore Recover and Remove--------------------------------------------#

# Use case : I want to restore my file which was in the state of a previous commit. How do I do it ?

# In Older versions :
git checkout abc1234 -- myprogram.py # abcd.. is the commit hash, -- informs the following is a file name
# In newer versions :
git restore --source=abc1234 myprogram.py # --source is the commit has you are interested in 


#Even if you commit or staged a file a copy will be saved, so you can restore the file
git restore myFile.json # Discard the changes you have made in the working directory and restore it to the previous commit

git restore --staged myFile.json #remove a file from staging area ( Restore a file to the working directory from stagin area)
git rm notes.txt -f/--cached  #remove a tracked file from git tracking (may be file is stagin area or not), --cached option will retain the file in directory, -f option will delete file permanently.
# Still we can see the file untracked state , to ignore this file permanently add that file name to a file called .gitignore
echo "myFile.json" >> .gitignore
cat .gitignore

#?----------------------------------------Git Log - Checking commit history--------------------------------------#

# Information you get : commit hash ,Author , Date , Commit message

git log  # check the details of commit history
git log --oneline # get a short description of commit history
git log --name-only #get the list of changed files and their authors/modifires
git log -n <number>  #get -n number of the latest (reverse chrono order) record of commit history , to get the latest value is '1'
git log --graph --decorate #to see previous commit history along with the branch they were committed on
git log --all # show all of the commits

git log origin/master # usually we check the log of local master branch, to check the log of remote repository using the origin(alias) and branch (master)

#Going back to previous version/commit
git checkout <commit_number> #commit number can get when you issue git log and see the number infront of each commit, this is a unique number

#?-----------------------------------------Git Branching-----------------------------------------------------------#
git branch newBranch  #Create a new branch
git checkout newBranch #Switch branches
git checkout -b newBranch2  #Create a new branch and immediately switch to the new branch
git branch -d newBranch2 #Delete a branch 
git branch #list all the branches currently you have
git branch -l # list the branches
git branch -a # show all branches inculding local and remote , current has *

#?--------------------------------------Git Merging a Branch -------------------------------------------------------#
git checkout master  #First checkout to master branch
git merge feature/signup #perform the merge 

# Squashing a branch
#What is squashing a branch ? 
git merge --squash FeatureA #merge FeatureA branch to the current checked out branch. Squash merge will happen with minimum commits

#?---------------------------------Working with Remote Repositories (GitHub)------------------------------------------#

# Git Hub , Git Lab and BitBucket available

#git remote add origin <Connection_String> ,Add a remote repo for a local project. 'origin' is an alias name for the remote, and also can have multiple remote repositories
git remote add origin https://..../../[name].git 
git remote -v  #List all remote repositories
# To work with remote repository we can fetch and push the data to the hosted repo, in this case we are fetching and pushing data from same remote repository.
# Thats why when we list, we can see two remote repositories with same name
git remote show # show remote repositories

git push origin master  # git push <aliasOfRemoteRepo> <CurrentBranch/BranchName>  , Push the data to remote repo
git clone http://git.example.com/sarah/story-blog  #clone a remote repository locally and work on it
#git clone [ssh link] 
#Once we cloned , we dont have to add the repository using git remote add command. Because in the clonning it automatically get added
git push -u origin master #creates a link between local master and remote master branches 
#Whenever new data added to remote master branch , automatically the local master branch will pull
#the data from there so next time, you dont have to specify git push origin master , instead perform
git push 
git push -u origin --all  #This pushes changes of all branches to origin
git push -u origin main  #This pushes changes only with the main branch

#?------------------------------------------Git Pull Request--------------------------------------------------------------#
#When working in collaboration , directly pushing the commits to the main branch is not advised
#instead perform the commits in sub-branch and then create a pull request
#Reviewers will review and approvers will aprove the code and merge the changes to main branch
#After than initiate a pull to fetch and merge the changes directly into our local master branch

#Fetching and Pulling
git fetch origin master #Update orgin/master branch in our local repository
git merge orgin/master #now we have an updated local master
git branch -a # view all the branches both local and remote
# Combined command 
git pull origin master # We can fetch and merge remote changes directly into our local master branch. No need to perform fetch and merge seperately. 

#? ------------------------------------------- Git Merge Conflicts ----------------------------------------------------------#
#* When few people work on same file , during the merge , merge conflicts can occur
#* Git add extra charachters to the files that are conflicting
#* Edit and remove the content that does not need to kept
#* Add the files to Git again and commit 
#* Now the later branch can be merged with master branch without any issues / you can push
#* Finally master branch contains the combination of everyone's work 

#?---------------------------------------------Forking---------------------------------------------------------------------#
# Forking means when it comes to remote repositories and open source projects ;  you are creating an exect copy of a project and work on independently or your own team. Then once you think you are good to contribute, then you make a pull request.
# Either you contribute or not its your decision. You can do your own experiments with it. 
# cloning applies for both local and remote repositories and when you are directly contributing the original project 

# step 1 : create a fork by clicking 'Fork' button - now under explore you can see a seperate copy 
# step 2 : clone the forked repository directly to your system
# step 3 : make changes (add , commit ) and push the changes to master branch of forked repository
# step 4 : login to GitUI and create a PR from forked repo to original repo
# step 5 : owners or admins will review and approve and merge the pull request finally

#?---------------------------------------------Rebasing----------------------------------------------------------------------#

# What is Git Rebasing ?  Changes from one branch brought on top of another branch. As a result this would re-write the Git History. I change my base. 

# Why we do it ? To update a branch with the latest changes from another branch or clean-up commit history before merging. Ensure Im caught up with all changes happening. 

#have not sent a pull request, but wanted to keep yourself caught up with updates 
#Question ? Whats the difference between pull (fetch + merge ) and rebasing ?
# Pull request is updating changes from remote repository to your master branch.  However,  rebase help to update your current branch with the master branch

#! Rebasing : Taking master branch and put your self on top of it , so rebase command issues from your branch 
#! Merge : Merge happening, by checking out to master branch and apply changes of your branch into it

git rebase master  #rebase your branch on top of master branch , you can specify the branch name
git rebase -i HEAD~4 # telling Git that we want to interactively rebase last 4 commits. We can use squash option to consolidate last 4 commits to a single commit and rebase.

git cherry-pick b1fbc37 #* Cherry pick a certain commit and add it your working branch , hash of the commit is given

#?------------------------------------------Resetting and Reverting------------------------------------------------------------#

# What is resetting and revertting ? How its different from restoring ?
# Git Revert : Git revert is used to undo changes from a specific commit by creating a new commit that applies the inverse of the changes. Unlike resetting, it doesn't alter the existing commit history.
# Git Reset : Git reset is used to undo changes in the local working directory and staging area (index). It can also alter the commit history in a branch.

git revert 8ad5d #reverse all changes made on a specific commit, useful for undoing changes ; can go back 
git revert HEAD~0 # revert the current/latest commit to previoys commit

# Git Reset : SOFT - keep changes made
git reset --soft HEAD~1 # revert the previous 1 commit back ( denoted by number ) while keeping all the changes were made ; Can go back ; Specific commit will be removed from GitHistory
git status #we still have access to the changes were made by resetted commit
git reset --hard HEAD~1 #Reset last 1 commit. the n number of commits (n=1) will be resetted without keeping changes made, you will lose the changes made ; no go back 
git status # we cannot see the changes made in previous commit

#?--------------------------------------------Stashing-------------------------------------------------------------------------#

# What is stashing in Git ? Git stashing is a feature in Git that allows you to temporarily shelve (or stash) changes you've made to your working directory so you can work on a different task. 
# Stash all changes in working area using Git stash command. 

# Changes are in staging area and tracked files. 

git stash #stash ( save ) all the changes in working area without commit. The modifications in working area get added to stash ( a pile) ?
git stash pop #get the changes back into the working area
git stash list #list all the stashes piled up on the stash
git stash show 	stash@{1} #see the content of certain stash
git stash pop stash@{1} #pop a specific stash instead of the last one
#Usually latest stash takes the index 0 , its a stack/pile (latest on the top) 

#?---------------------------------------------Reflog---------------------------------------------------------------------------#

# What is Reflogging in Git ? Its a log that helps you to recover your Git repository incase of deletion or disaster recovery. 

git reflog #shows all the actions that have been taken on the repo
#How to recover using reflog : Refer the reflog and perform a hard reset to the point where you want to restore
git reset --hard 8ad5
#git log only gives you the history of events, but reflog gives you all the states of the repository including merges, resets , reverts etc. 

#To see the commits in form of a graph
git log --graph

#?-----------------------------------------Tagging in Git------------------------------------------------------------------------#

# What is tagging in Git ?

git tag -a v1.0 -m "Version 1.0 release"  #tag the current commit you are on
git tag #check all the tags placed in current branch
git tag v1.0  #shows the version already exists

#?-----------------------------------------Miscellaneous-------------------------------------------------------------------------#
git show
git diff myfile # if there are changes , shows what has changed

#!--- End of the Note --#



