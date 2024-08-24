# classify regions by cities
north <- c(
  "New York, NY",
  "Providence, RI",
  "Boston, MA",
  "Philadelphia, PA",
  "Pittsburgh, PA"
)

south <- c(
  "Dallas, TX",
  "Houston, TX",
  "Miami, FL",
  "Tampa, FL",
  "Atlanta, GA"
)

midwest <- c(
  "Chicago, IL",
  "Detroit, MI",
  "Minneapolis, MN",
  "St. Louis, MO",
  "Cincinnati, OH"
)

mountain <- c(
  "Phoenix, AZ",
  "Denver, CO",
  "Las vegas, NV",
  "Salt Lake City, UT",
  "Tucson, AZ"
)

pacific <- c(
  "Los Angeles, CA",
  "San Francisco, CA",
  "Riverside, CA",
  "Seattle, WA",
  "San Diego, CA"
)

get_region <- function(city) {
  if (city %in% north) {
    return('north')
  }
  else if(city %in% south) {
    return('south')
  }
  else if(city %in% midwest) {
    return('midwest')
  }
  else if(city %in% mountain) {
    return('mountain')
  }
  else if(city %in% pacific) {
    return('pacific')
  }
}