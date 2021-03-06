# git-to-beeminder

Track local git commits in Beeminder.

This bash script prompts you to submit the latest git commit as a datapoint for
one of your [Beeminder][1] goals. Intended to be used as part of a local
[post-commit hook][2].

Beeminder already has [great integration with Github][3], but most of my repos
aren't hosted there. This script also gives you the flexibility to, say, count
multiple repos towards the same goal (there's an option to prefix the
datapoint's message, if you want to clarify which repo the commit came from in
that case).

## Quick start

Assuming you don't already have a `post-commit` hook:

1. Copy `post-commit.sample` to your repo's `.git/hooks` directory
2. Rename it to `post-commit`
3. Fill in your config values and the path where you've cloned this repo
4. Make it executable: `chmod +x post-commit`

i.e.:
```
cp post-commit.sample /path/to/your/repo/.git/hooks/
cd $_
mv post-commit.sample post-commit
chmod +x post-commit
vi post-commit  # ...fill in config values...
```

## Notes

Tested on OS X 10.10 with Git 1.9.3 and Ubuntu 14.04 with Git 1.9.1.

See [this blog post][4] for more background.

Contact: mark@warkmilson.com

[1]: https://www.beeminder.com/
[2]: http://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks#Client-Side-Hooks
[3]: https://www.beeminder.com/gitminder
[4]: http://warkmilson.com/2015/01/31/local-git-commits-to-beeminder.html
