generate_html <- function(paths) {
    str_c(
        '<div class="scroll-container">\n\t<div class="gridscroll">\n\t\t',
        str_c(str_glue('<img src="{paths}">'), collapse = "\n\t\t"),
        '\n\t</div>\n</div>', 
        sep = ""
    )
}

get_images <- function(dir = "www/images/") {
    
    tibble(
        path = list.files("www/images/", recursive = TRUE)
    ) %>% 
        mutate(
            type = str_split(path, "/") %>% map_chr(pluck, 1),
            id = str_split(path, "/") %>% map_chr(pluck, 2) %>% as.numeric()
        ) %>% 
        group_by(type, id) %>% 
        summarize(html = generate_html(path)) %>% 
        ungroup()
    
}

get_dameges <- function() {
    tibble(
        type = c("school", "school"),
        id = c(17, 35),
        latitude = c(50.02146036833384, 49.936112353184306), 
        longitude = c(36.32800614300417, 36.251797616496205)
    )
}
