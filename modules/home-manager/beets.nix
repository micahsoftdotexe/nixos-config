{ ... }:
{
  flake.homeModules.beets =
    { ... }:
    {
      programs.beets = {
        enable = true;
        # The default pkgs.beets already bundles every plugin (discogs, chroma,
        # deezer, spotify, ...) with its deps and the fpcalc binary, so no
        # package override is needed.

        settings = {
          # Organized library lives here. Originals in the source dir are left
          # untouched because we copy (see import.copy) instead of moving.
          directory = "~/Music";
          library = "~/.config/beets/library.db";

          # Metadata sources + helpers.
          # - musicbrainz: default source (same as Picard)
          # - discogs/deezer/spotify: extra databases that often have albums
          #   MusicBrainz is missing
          # - chroma: acoustic fingerprinting (AcoustID), for untagged files
          plugins = [
            "musicbrainz"
            "discogs"
            "deezer"
            "spotify"
            "chroma"
            "fromfilename" # guess tags from filenames when metadata is empty
            "ftintitle" # move "feat. X" out of artist into title
            "fetchart" # download cover art
            "embedart" # embed cover art into the files
            "lyrics"
            "scrub" # strip pre-existing junk tags before writing clean ones
            "edit" # interactively edit matches during import
            "info"
            "duplicates"
          ];

          import = {
            move = false; # don't move source files...
            copy = true; # ...copy them into `directory` instead
            write = true; # write tags to the (copied) files
            resume = true;
            incremental = true; # skip dirs already imported on re-runs
          };

          match = {
            # Auto-accept reasonably strong matches without prompting.
            # Lower = more lenient. Default is 0.04.
            strong_rec_thresh = 0.10;
          };

          paths = {
            default = "$albumartist/$album%aunique{}/$track $title";
            singleton = "Non-Album/$artist/$title";
            comp = "Compilations/$album%aunique{}/$track $title";
          };

          fetchart.maximum_width = 1200;
          embedart.maxwidth = 1200;

          # Discogs auth: anonymous lookups are rate-limited and often return
          # nothing. Either run a one-time OAuth (`beet import` will prompt and
          # save a token to ~/.config/beets/discogs_token.json), or paste a
          # personal token from https://www.discogs.com/settings/developers
          # here. Do NOT commit a real token to a public repo.
          # discogs.user_token = "YOUR_DISCOGS_TOKEN";
        };
      };
    };
}
