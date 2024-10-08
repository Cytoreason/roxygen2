test_that("warn if forgotton colom", {
  expect_snapshot_warning(
    roc_proc_text(rd_roclet(), "
      #' Foo
      #'
      #' @section Haz dox
      #' Here.
      #' There
      foo <- function(x = '%') x
    ")
  )
})

test_that("@section-s with identical titles are merged", {
  out <- roc_proc_text(rd_roclet(), "
    #' Foo
    #'
    #' @section Haz dox: Here.
    #'
    #' @section TL: DR.
    foo <- function(x = '%') x

    #' @rdname foo
    #' @section RT: FM.
    #' @section Haz dox:
    #'   Got news.
    bar <- function(y = '%') y
  ")[[1]]

  expect_equal(
    out$get_section("section"),
    rd_section_section(
      c("Haz dox", "TL", "RT"),
      c(" Here.\n\n\n  Got news.", " DR.", " FM.")
    )
  )
})

test_that("@section-s with different titles are kept as they are", {
  out <- roc_proc_text(rd_roclet(), "
    #' Foo
    #'
    #' @section A: 1
    #' @section B: 2
    foo <- function(x) x

    #' @rdname foo
    #' @section C: 3
    bar <- function(x) x
  ")[[1]]

  expect_equal(
    out$get_section("section"),
    rd_section_section(LETTERS[1:3], c(" 1", " 2", " 3"))
  )
})
