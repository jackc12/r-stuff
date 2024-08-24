get_percents <- function(row) {
  total <- row$total
  c(
    asian = row$asian / total,
    black = row$black / total,
    hispanic = row$hispanic / total,
    other = row$other / total,
    white = row$white / total
  )
}