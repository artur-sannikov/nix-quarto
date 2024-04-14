library(rix)

path_default_nix <- getwd()

rix(r_ver = "latest",
    git_pkgs = list(
           package_name = "rix",
           repo_url = "https://github.com/b-rodrigues/rix",
           branch_name = "master",
           commit = "76d1bdd03d78589d399b4b9d473ecde616920a82"),
    r_pkgs = c("quarto"),
    system_pkgs = "quarto",
    tex_pkgs = c(
        "amsmath",
        "orcidlink",
        "tcolorbox"
    ),
    ide = "other",
    project_path = path_default_nix,
    overwrite = TRUE,
)
