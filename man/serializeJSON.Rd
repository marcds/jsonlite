\name{serializeJSON}
\alias{serializeJSON}
\alias{unserializeJSON}
\title{Serialize R objects to JSON}
\usage{
  serializeJSON(x, digits = 8, pretty = FALSE)

  unserializeJSON(txt)
}
\arguments{
  \item{x}{an R object to be serialized}

  \item{digits}{max number of digits (after the dot) to
  print for numeric values}

  \item{pretty}{add indentation/whitespace to JSON output.
  See \code{\link{prettify}}}

  \item{txt}{a JSON string which was created using
  \code{serializeJSON}}
}
\description{
  Just like \code{\link{toJSON}} and
  \code{\link{fromJSON}}, the \code{\link{serializeJSON}}
  and \code{\link{unserializeJSON}} functions convert
  between R objects to JSON. However instead of using a
  class based encoding, the serialize functions base the
  encoding schema on the storage type of an object. They
  use a much more verbose encoding schema which captures
  all data and attributes from any object, such that it can
  be almost perfectly restored from its JSON
  representation. Almost all storage types (except for
  environments) are supported.
}
\details{
  Note that JSON is a text based format which leads to loss
  of precision when printing numbers.
}
\examples{
jsoncars <- serializeJSON(mtcars)
mtcars2 <- unserializeJSON(jsoncars)
identical(mtcars, mtcars2)

set.seed('123')
myobject <- list(
  mynull = NULL,
  mycomplex = lapply(eigen(matrix(-rnorm(9),3)), round, 3),
  mymatrix = round(matrix(rnorm(9), 3),3),
  myint = as.integer(c(1,2,3)),
  mydf = cars,
  mylist = list(foo="bar", 123, NA, NULL, list("test")),
  mylogical = c(TRUE,FALSE,NA),
  mychar = c("foo", NA, "bar"),
  somemissings = c(1,2,NA,NaN,5, Inf, 7 -Inf, 9, NA),
  myrawvec = charToRaw("This is a test")
);
identical(unserializeJSON(serializeJSON(myobject)), myobject);
}
