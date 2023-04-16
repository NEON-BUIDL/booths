#!/bin/bash


# Function to print HTML header
print_html_header() {
    echo "<!DOCTYPE html>"
    echo "<html>"
    echo "<head>"
    echo "<meta charset=\"UTF-8\">"
    echo "<title>Image Gallery</title>"
    echo "<style>"
    echo "  .gallery {"
    echo "    display: grid;"
    echo "    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));"
    echo "    grid-gap: 10px;"
    echo "  }"
    echo "  .gallery img {"
    echo "    width: 100%;"
    echo "    height: 100%;"
    echo "    object-fit: cover;"
    echo "  }"
    echo "</style>"
    echo "</head>"
    echo "<body>"
    echo "<div class=\"gallery\">"
}

# Function to generate HTML gallery
generate_html_gallery() {
    local dir="$1"

    ## Add ability to find gif if thumbnails become animated in future
    find "$dir" -type f -name "*.png" | while read -r file; do
        local glb_file="${file%.*}.glb"
        echo "  <a href="$glb_file"><img src="$file"></a>"
    done
}

# Main function
main() {
    local dir="$1"
    local print_header=false
    local print_footer=false
    local print_body=false

    # Check if optional flag is passed
    while [[ $# -gt 0 ]]; do
        case "$2" in
            --head)
                print_header=true
                shift
                ;;
            --body)
                print_body=true
                shift
		;;
            --tail)
                print_footer=true
                shift
                ;;
            *)
                break
                ;;
        esac
    done

    # Generate HTML gallery
    if [[ $print_header == true ]]; then
	    print_html_header
    fi

    if [[ $print_body == true ]]; then
	    generate_html_gallery "$dir"
    fi

    # Print closing HTML tags if --tail flag is passed
    if [[ $print_footer == true ]]; then
      echo "</div>"
      echo "</body>"
      echo "</html>"
    fi
}

main "$@"

