# write_if_different produces informative messages

    Code
      write_if_different(path, "a <- 2")
    Message
      Writing 'test.R'
    Output
      [1] TRUE

---

    Code
      write_if_different(path, "a <- 2")
    Condition
      Warning:
      Skipping 'test.R'
      x It already exists and was not generated by roxygen2.
    Output
      [1] FALSE

---

    Code
      write_if_different(path, "a <- 2")
    Condition
      Warning:
      Skipping '+.R'
      x Invalid file name
    Output
      [1] FALSE

