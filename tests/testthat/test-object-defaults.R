test_that("@docType data automatically adds sensible defaults", {
  out <- roc_proc_text(rd_roclet(), "
    #' Title.
    #'
    #' @docType data
    a <- data.frame(a = 1:10)
  ")[[1]]

  expect_equal(out$get_value("usage"), rd("a"))
  expect_equal(out$get_value("keyword"), "datasets")
  expect_false(is.null(out$get_value("format")))
})

test_that("@docType data automatically added to data objects", {
  out <- roc_proc_text(rd_roclet(), "
    #' Title.
    a <- data.frame(a = 1:10)
  ")[[1]]

  expect_equal(out$get_value("docType"), "data")
})

test_that("@docType data automatically added to data objects created elsewhere", {
  out <- roc_proc_text(rd_roclet(), "
    a <- data.frame(a = 1:10)
    #' Title.
    'a'
  ")[[1]]

  expect_equal(out$get_value("docType"), "data")
  expect_equal(out$get_value("usage"), rd("a"))
  expect_equal(out$get_value("keyword"), "datasets")
})

# Reference classes ----------------------------------------------------------

test_that("@docType class automatically added to reference class objects", {
  out <- roc_proc_text(rd_roclet(), "
    #' Title.
    #'
    a <- setRefClass('a')")[[1]]

  expect_equal(out$get_value("docType"), "class")
})

# packages -----------------------------------------------------------------

test_that("can create package documentation", {
  local_package_copy(test_path("empty"))
  desc::desc_set(
    Package = "roxygendevtest",
    Title = "Package Title",
    Description = "Package description."
  )

  block <- "
    #' @details Details.
  '_PACKAGE'
  "
  blocks <- parse_text(block, env = new.env())
  out <- roclet_process(rd_roclet(), blocks, env = new.env(), base_path = ".")[[1]]

  expect_equal(out$get_value("name"), "roxygendevtest-package")
  expect_equal(out$get_value("alias"), c("roxygendevtest", "roxygendevtest-package"))
  expect_equal(out$get_value("title"), "roxygendevtest: Package Title")
  expect_equal(out$get_value("description"), "Package description.")
  expect_equal(out$get_value("docType"), "package")
  expect_equal(out$get_value("details"), "Details.")
})

