{ pkgs, ...}:
pkgs.writers.writeBash "screenshot" ''
    save_dir="$HOME/Pictures/Screenshots"

    # Create the directory if it doesn't exist
    mkdir -p "$save_dir"

    # Get the geometry from slurp (user selection)
    geometry=$(${pkgs.slurp}/bin/slurp)

    # Check if geometry is empty (escape was pressed or selection is invalid)
    if [ -z "$geometry" ]; then
        echo "No selection made, exiting without saving screenshot."
        exit 0
    fi

    # Set the base filename with the current date
    base_filename="screenshot-$(date -I)"
    extension=".png"
    filename="$save_dir/$base_filename$extension"

    # Check if a file with the same name already exists
    n=1
    while [ -e "$filename" ]; do
        filename="$save_dir/$base_filename($n)$extension"
        ((n++))
    done

    # Capture screenshot with grim, process it with convert, and save to the determined filename
    ${pkgs.grim}/bin/grim -g "$geometry" - | ${pkgs.imagemagick}/bin/convert - -shave 1x1 PNG:- > "$filename"
  ''
