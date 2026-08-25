# Wiki

The pages in this directory are the source of the wiki published at
<https://github.com/LandSandBoat/server/wiki>. The published wiki is read-only. Edit the pages
here and open a pull request against `base`.

When a push to `base` changes anything in `docs/wiki`, the
[Publish Wiki](../../.github/workflows/publish_wiki.yml) workflow copies this directory over the
published wiki and pushes it. Nothing outside this directory is published, and this `README.md`
is not published either.

## Writing a page

- One markdown file per page. The file name is the page name, with hyphens for spaces:
  `Quick-Start-Guide.md` becomes the `Quick-Start-Guide` page.
- Link to another page by its name: `[Quick Start Guide](Quick-Start-Guide)`.
- Link into the repository with a full URL on the `base` branch, because the published wiki is a
  separate repository and cannot use relative paths.
- Put images in `images/` and reference them as `images/name.png`.
- Add every new page to `Home.md` and to `_Sidebar.md`. A page that neither one links to is
  reachable only by search.
