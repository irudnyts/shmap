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
        path = list.files(dir, recursive = TRUE)
    ) %>% 
        mutate(
            type = str_split(path, "/") %>% map_chr(pluck, 1),
            id = str_split(path, "/") %>% map_chr(pluck, 2) %>% as.numeric(),
            path = str_c("images/", path)
        ) %>% 
        group_by(type, id) %>% 
        summarize(html = generate_html(path)) %>% 
        ungroup()
    
}

get_dameges <- function() {
    tibble(
        type = c("school", "school", "school", "school", "school"),
        id = c(17, 35, 42, 118, 134),
        latitude = c(50.02146036833384, 49.936112353184306, 50.02025763564293, 49.93792533646303, 50.010585607906584), 
        longitude = c(36.32800614300417, 36.251797616496205, 36.372334765072665, 36.403840744034106, 36.285952067994614)
    ) %>% 
    mutate(
      object_id = row_number()
    )
}

set_clusters_class <- "function (cluster) {    
    var childCount = cluster.getChildCount(); 
    var c = ' marker-custom-';  
    if (childCount < 4) {  
      c += 'small';  
    } else if (childCount < 10) {  
      c += 'medium';  
    } else { 
      c += 'large';  
    }    
    return new L.DivIcon({ html: '<div><span>' + childCount + '</span></div>', className: 'marker-cluster' + c, iconSize: new L.Point(40, 40) });

  }"