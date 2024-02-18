readr::read_csv("data-raw/layout.csv") |>
  janitor::clean_names() |>
  dplyr::mutate(text = stringr::str_remove_all(text, "^'")) |>
  dplyr::mutate(text = ifelse(is.na(text), layout, text)) |>
  dplyr::mutate(text = ifelse(stringr::str_detect(layout, "Title"), paste("\n#", text), text)) |>
  dplyr::mutate(text = ifelse(stringr::str_detect(tolower(layout), "header"), paste("\n##", text), text)) |>
  dplyr::filter(!stringr::str_detect(layout, "Page number|Footer")) |>
  dplyr::pull(text) |>
  paste(collapse = "\n") |>
  write("data-raw/incentives.md")
