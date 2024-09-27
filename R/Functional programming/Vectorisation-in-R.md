-   [1 Check out these resources](#resources)
-   [2 Functional programming](#functional_programming)
-   [3 Vectors in R](#vectors_r)
-   [4 For loops](#for_loops)
-   [5 Functionals](#functionals)
-   [6 Why use functionals over for loops?](#use_functionals)
-   [7 Why use purrr over apply?](#purrr_over_apply)
-   [8 Features: Multiple inputs](#features_1)
-   [9 Features: passing extra constant arguments](#constant_arguments)
-   [10 Features: Anonymous functions](#anonymous_functions)
-   [11 Use case: Curly braces and avoiding nested loops](#nesting)
-   [12 Pre-processing data frames that need to have uneven
    widths](#pre-processing-data-frames-that-need-to-have-uneven-widths)

# 1 Check out these resources

[Functional programming | Advanced R](https://adv-r.hadley.nz/fp.html)

[21 Iteration | R for Data
Science](https://r4ds.had.co.nz/iteration.html)

(I heavily borrowed from them for this presentation.)

# 2 Functional programming

-   R is predominantly a functional programming language.

-   Functional languages have first-class functions:

    -   you can assign them to variables

    -   store them in lists,

    -   **pass them as arguments to other functions,**

    -   create them inside functions,

    -   and even return them as the result of a function.

-   Declarative (tell a function to do something, it does it for you)
    not imperative (computer, do exactly this in this order).

-   The functional programming *style* is about breaking down
    programming into logical tasks/sub-tasks and then completing those
    tasks with a function or combination of functions.

# 3 Vectors in R

-   A vector is a one-dimensional array

<!-- -->

    # This is a vector
    print(1:4)

    ## [1] 1 2 3 4

    # This is also a vector
    print(c(1, 2, 3, 4))

    ## [1] 1 2 3 4

    # A list is a vector whose elements can be of any class
    print(list(1, "B", TRUE, pi))

    ## [[1]]
    ## [1] 1
    ## 
    ## [[2]]
    ## [1] "B"
    ## 
    ## [[3]]
    ## [1] TRUE
    ## 
    ## [[4]]
    ## [1] 3.141593

-   R data frames are literally a named list of vectors with some extra
    attributes (names of the vectors are the column names, row names and
    object class).

-   Most of R’s functions are vectorised, meaning that the function will
    operate on all elements of a vector without needing to loop through
    and act on each element one at a time.

<!-- -->

    # We can do this
    x <- 1:4
    print(x * 2)

    ## [1] 2 4 6 8

    # Rather than this
    print(c(x[1] * 2, x[2] * 2, x[3] * 2, x[4] * 2))

    ## [1] 2 4 6 8

# 4 For loops

-   Sometimes a (vectorised) function doesn’t exist for a particular
    operation or series of more complex operations and/or there is a
    need for a row-wise operation.

-   A for loop is how most people would approach this sort of problem.

<!-- -->

    # How would I create a cumulative sum for a vector? (Pretending cumsum() doesn’t exist)

    # create a vector
    x <- 1:4

    # pre-allocate output
    result <- numeric(length(x))
    sum <- 0

    # kick off the for loop
    for (i in seq_along(x)) {
      # don't forget to assign the output!
      sum <- sum + x[i]
      result[i] <- sum
    }
    print(result)

    ## [1]  1  3  6 10

# 5 Functionals

> Functional languages have first-class functions:
>
> -   you can assign them to variables
>
> -   store them in lists
>
> -   **pass them as arguments to other functions**

-   A functional is a function that takes another function as one of its
    arguments and returns a vector as output.

    -   Contrast to a for loop where the elements of a vector are
        calculated element-wise.

-   Examples of functionals are the map family from `purrr` and the
    apply family from base R (`lapply()`, `mapply()`, `capply()`,
    `tapply()`, `sapply()` etc).

<!-- -->

    # create a basic function that cubes its input
    cubed <- function(x) x^3

    # apply the function to each element of a vector
    map(1:3, cubed) # 1:3 is the vector, cubed is the function

    ## [[1]]
    ## [1] 1
    ## 
    ## [[2]]
    ## [1] 8
    ## 
    ## [[3]]
    ## [1] 27

    # The equivalent for loop to map(1:3, cubed) is:

    # pre-allocate output
    result <- vector("list", length(1:3))

    for (i in 1:3) {
      # assign the output
      result[[i]] <- i^3
    }
    result

    ## [[1]]
    ## [1] 1
    ## 
    ## [[2]]
    ## [1] 8
    ## 
    ## [[3]]
    ## [1] 27

# 6 Why use functionals over for loops?

If map/apply() are equivalent for a for loop, why use them?

-   Each functional takes a vector as input, applies a function to each
    element, and then returns a new vector that’s the same length (and
    has the same names) as the input.

    -   Contrast to the element-wise building of a vector with a for
        loop, and assigning names is another step.

-   Concise (map = 1 line, for loop = 4 lines) and clear (for this
    input, apply this function).

-   Better suited to the functional programming style (using a
    function(al) for a task rather than a loop).

-   Control of the process is simpler/handled by the function:

    -   In a for loop, steps include pre-allocating the output,
        assigning the output, error handling, consideration for vectors
        of length zero, all of which can be difficult to follow when
        using nested conditions and nested loops.

-   Generalisability (for repeated tasks or when applying a series of
    functions)

# 7 Why use purrr over apply?

-   Syntax is standardised across the `purrr::map` family

    -   Apply family have different naming conventions and syntax for
        each function
    -   map syntax is always read as: for each element of this input,
        apply this function

-   `purrr` allows clearer control over output type by specifying
    map\_\*() with a suffix:

    -   `map()` always returns a list
    -   \_lgl for logical (`map_lgl`)
    -   \_int for integer (`map_int`)
    -   \_dbl for double (`map_dbl`)
    -   \_chr for character (`map_chr`)
    -   \_vec for atomic vector (`map_vec`)
    -   `modify()` returns output in the same format as the input

-   All `map()` variants can take any type of vector as input (including
    whole data frames).

-   furrr: `furrr::future_map()` and variants can use multicore-,
    multisession-, and cluster-based parallel processing.

<span style="font-size:10px;">\*Map refers to “an \[mathematical\]
operation that associates each element of a given set with one or more
elements of a second set”. In this case, map() defines a mapping from
one vector to another.</span>

# 8 Features: Multiple inputs

But you have two (or more) inputs?

`map2()`, `imap()` and `pmap()` have you covered.

    # map2: map in parallel over two inputs ####
    # Task: From three normal distributions each with a different mean and SD, generate 5 random numbers

    # create two lists of input
    # one for three different means
    mu <- list(5, 10, -3)

    # The other for three different SDs
    sigma <- list(1, 5, 10)

    # use map2() to iterate over both inputs
    map2(mu, sigma, rnorm, n = 5) %>% str()

    ## List of 3
    ##  $ : num [1:5] 4.3 5.99 5.2 4.65 5.79
    ##  $ : num [1:5] 12.32 15.17 7.65 18.42 9.01
    ##  $ : num [1:5] 8.9449 -0.0707 0.1936 2.1169 -22.8266

    # imap: iterate over the values and indices of a vector in parallel ####
    # Task: for each index of the vector, find the highest value and print which index of the list you are referring to

    # create a list with 6 lists of 10 random numbers
    x <- map(1:6, ~ sample(1000, 10))
    str(x)

    ## List of 6
    ##  $ : int [1:10] 479 388 861 248 776 921 279 152 208 883
    ##  $ : int [1:10] 4 229 768 55 309 341 184 925 707 487
    ##  $ : int [1:10] 440 1 959 335 743 852 45 601 441 283
    ##  $ : int [1:10] 620 488 727 974 91 673 495 257 178 693
    ##  $ : int [1:10] 791 32 148 159 870 672 738 68 419 924
    ##  $ : int [1:10] 978 734 863 318 83 524 773 722 488 506

    # for each index of the vector, find the highest value and print which index of the list you are referring to
    imap_chr(x, ~ paste0("The highest value of ", .y, " is ", max(.x)))

    ## [1] "The highest value of 1 is 921" "The highest value of 2 is 925"
    ## [3] "The highest value of 3 is 959" "The highest value of 4 is 974"
    ## [5] "The highest value of 5 is 924" "The highest value of 6 is 978"

    # pmap: map over an arbitrary number of inputs provided in a list ####
    # Task: create a pre-specified amount of random numbers from 3 different normal distribution each with a different mean and SD
    # Nb- as any input format can be provided and we have 3 arguments of length 3, we can create a small data frame to pass in as the input.
    params <- tribble(
      ~mean, ~sd, ~n,
      5, 1, 1, # one random number from a normal distribution with mean of 5 and SD of 1
      10, 5, 3, # three random numbers from a normal distribution with mean of 10 and SD of 5
      -3, 10, 5 # five random numbers from a normal distribution with mean of -3 and SD of 10
    )

    # take params as the input and apply the function rnorm()
    params %>%
      pmap(rnorm) %>%
      str()

    ## List of 3
    ##  $ : num 4.87
    ##  $ : num [1:3] 12.99 6.74 1.92
    ##  $ : num [1:5] -2.181 -2.648 -15.056 -0.767 -6.245

# 9 Features: passing extra constant arguments

-   In the previous example for `map2()`, the following syntax was used:
    `map2(mu, sigma, rnorm, n = 5) %>% str()`

-   Here, n = 5 was an extra constant argument passed to `rnorm()`

<!-- -->

    # Another example is a data frame that contains NAs and you want means for each column
    df <- data.frame(
      Column1 = c(1, 2, 3, 4, 5),
      Column2 = c(NA, 7, 8, NA, 10),
      Column3 = c(11, NA, 13, 14, NA)
    )

    map_vec(df, mean)

    ## Column1 Column2 Column3 
    ##       3      NA      NA

    # Oh no, NAs returned!

-   `map()` passes to the function the extra arguments (…) specified
    after the function (these arguments are not varied across the
    iterations). In R talk, the inputs are `map(.x, .f, ...)`.

<!-- -->

    # Another example is a data frame that contains NAs and you want means for each column
    df <- data.frame(
      Column1 = c(1, 2, 3, 4, 5),
      Column2 = c(NA, 7, 8, NA, 10),
      Column3 = c(11, NA, 13, 14, NA)
    )

    map_vec(df, mean, na.rm = T)

    ##   Column1   Column2   Column3 
    ##  3.000000  8.333333 12.666667

    # No more NAs returned!

# 10 Features: Anonymous functions

-   An alternative to the approach in use case 2 is to create an
    anonymous function (yes, a lambda…)

<!-- -->

    df <- data.frame(
      Column1 = c(1, 2, 3, 4, 5),
      Column2 = c(NA, 7, 8, NA, 10),
      Column3 = c(11, NA, 13, 14, NA)
    )

    map(df, function(x) mean(x, na.rm = T))

    ## $Column1
    ## [1] 3
    ## 
    ## $Column2
    ## [1] 8.333333
    ## 
    ## $Column3
    ## [1] 12.66667

-   But that form is a bit verbose. Thankfully there is a `purrr`
    shorthand for an anonymous function, the `~`

<!-- -->

    # .x is the syntax to specify the current vector that map is vectorised over.
    map(df, ~ mean(.x, na.rm = T))

    ## $Column1
    ## [1] 3
    ## 
    ## $Column2
    ## [1] 8.333333
    ## 
    ## $Column3
    ## [1] 12.66667

# 11 Use case: Curly braces and avoiding nested loops

-   map\_\*() also accepts curly braces in an anonymous function which
    allows for complex multi-line functions.

    -   e.g. `# map(df, ~{my complex function here})`

-   IMO, combining `map()` or its variants and an anonymous function
    with `nest()` is the biggest and best use case for functionals.

-   The `nest()` function creates a list-column of data frames where you
    get one row for each group defined by the non-nested columns. This
    is useful in conjunction with other summaries that work with whole
    datasets, most notably models.

-   I had a dataset of 7 questionnaires stored in a wide-format data
    frame. The functions I was going to use to perform the modelling
    (CFA/composite reliability scores) required wide-format data.

-   Each questionnaire had a different number of items (12, 12, 13, 10,
    20, 20, 20) and the items for the last three questionnaires were not
    sequential i.e. not items 1-20 inclusive.

-   I couldn’t pivot longer, filter for the desired items for each
    scale, then pivot wider again (that would re-introduce the columns
    for the questionnaires with less items).

-   I could split into 7 data frames, then run the modelling 7 times on
    each one but that is a lot of code duplication plus the modelling
    was to be run on 4 severity categories per assessment scale.

-   I could split into 7 data frames, then pass a <u>list of those data
    frames</u> into `map()` with a self-defined function with the
    modelling functions. But wait, a list of data frames… nest() creates
    a <u>list-column of data frames</u>…

# 12 Pre-processing data frames that need to have uneven widths

    # Let's have a quick look at the data
    print(activation_final, n = 5)

    ## # A tibble: 169,563 × 28
    ##   nocc_episode_identifier severity_category assessment_scale item1 item2 item3
    ##   <chr>                   <chr>             <chr>            <int> <int> <int>
    ## 1 107183                  mild              HoNOS                1     0     0
    ## 2 183775                  mild              HoNOS                0     0     0
    ## 3 100797                  severe            HoNOS                1     2     3
    ## 4 100135                  subclinical       HoNOS                0     0     1
    ## 5 100818                  severe            HoNOS                2     0     0
    ## # ℹ 169,558 more rows
    ## # ℹ 22 more variables: item4 <int>, item5 <int>, item6 <int>, item7 <int>,
    ## #   item8 <int>, item9 <int>, item10 <int>, item11 <int>, item12 <int>,
    ## #   item13 <int>, item14 <int>, item15 <int>, item16 <int>, item17 <int>,
    ## #   item18 <int>, item19 <int>, item20 <int>, item21 <int>, item22 <int>,
    ## #   item23 <int>, item24 <int>, item25 <int>

    # just to show what nest() does
    nested_example <- activation_final %>%
      nest(., .by = c(assessment_scale, severity_category), .key = "nested_data")

    print(nested_example, n = 5)

    ## # A tibble: 28 × 3
    ##   assessment_scale severity_category nested_data           
    ##   <chr>            <chr>             <list>                
    ## 1 HoNOS            mild              <tibble [13,648 × 26]>
    ## 2 HoNOS            severe            <tibble [33,087 × 26]>
    ## 3 HoNOS            subclinical       <tibble [2,591 × 26]> 
    ## 4 HoNOS            moderate          <tibble [15,846 × 26]>
    ## 5 K10              non-clinical      <tibble [8,448 × 26]> 
    ## # ℹ 23 more rows

    # activation_final %>% group_by(assessment_scale) %>% nest() is equivalent but groups the data, an important distinction that will reduce performance if using furrr::future_map()

    # first step is to create a data frame with the assessment scales and the list of items to be selected

    scale_items <- tibble(
      assessment_scale = c("HoNOS", "HoNOS65", "HoNOSCA", "K10", "SDQ-PC", "SDQ-PY", "SDQ-YR"),
      selected_cols = list(
        list("item1", "item2", "item3", "item4", "item5", "item6", "item7", "item8", "item9", "item10", "item11", "item12"),
        list("item1", "item2", "item3", "item4", "item5", "item6", "item7", "item8", "item9", "item10", "item11", "item12"),
        list("item1", "item2", "item3", "item4", "item5", "item6", "item7", "item8", "item9", "item10", "item11", "item12", "item13"),
        list("item1", "item2", "item3", "item4", "item5", "item6", "item7", "item8", "item9", "item10"),
        list("item2", "item3", "item5", "item6", "item7", "item8", "item10", "item11", "item12", "item13", "item14", "item15", "item16", "item18", "item19", "item21", "item22", "item23", "item24", "item25"),
        list("item2", "item3", "item5", "item6", "item7", "item8", "item10", "item11", "item12", "item13", "item14", "item15", "item16", "item18", "item19", "item21", "item22", "item23", "item24", "item25"),
        list("item2", "item3", "item5", "item6", "item7", "item8", "item10", "item11", "item12", "item13", "item14", "item15", "item16", "item18", "item19", "item21", "item22", "item23", "item24", "item25")
      )
    )

    # The last step is to group the data by assessment scale and nest the data, then use map2 (map with 2 inputs) to feed in nested_data (name of the column in the nested data frame that contains all other columns other than assessment_scale) and the name of the assessment scale. The anonymous function defined in map2() then is performed on each nested table. It matches the assessment scale in activation_final & scale_items, extracts the list of column names, then selects just those columns that are relevant to each assessment scale.

    nested_example$nested_data <-
        # map over two inputs; the nested data and the column that contains the items for the assessment scales
          map2(nested_example$nested_data, nested_example$assessment_scale, ~ {
            # create a new object containing the columns that will be selected
            cols <- scale_items %>%
              # filter for current assessment scale (.y is the assessment_scale column)
              filter(assessment_scale == .y) %>%
              # extract the list of columns from scale_items
              pull(selected_cols) %>%
              # unlist to make it easier to work with
              unlist()
            # going back to nested_data (.x) to select just the relevant columns
            .x %>%
              select(nocc_episode_identifier, all_of(cols))
          })

    print(nested_example)

    ## # A tibble: 28 × 3
    ##    assessment_scale severity_category nested_data           
    ##    <chr>            <chr>             <list>                
    ##  1 HoNOS            mild              <tibble [13,648 × 13]>
    ##  2 HoNOS            severe            <tibble [33,087 × 13]>
    ##  3 HoNOS            subclinical       <tibble [2,591 × 13]> 
    ##  4 HoNOS            moderate          <tibble [15,846 × 13]>
    ##  5 K10              non-clinical      <tibble [8,448 × 11]> 
    ##  6 K10              severe            <tibble [29,191 × 11]>
    ##  7 K10              moderate          <tibble [6,370 × 11]> 
    ##  8 K10              mild              <tibble [5,159 × 11]> 
    ##  9 HoNOS65          subclinical       <tibble [333 × 13]>   
    ## 10 HoNOS65          mild              <tibble [2,416 × 13]> 
    ## # ℹ 18 more rows

    nested_example %>%
      mutate(no_columns = map_vec(nested_data, ncol))

    ## # A tibble: 28 × 4
    ##    assessment_scale severity_category nested_data            no_columns
    ##    <chr>            <chr>             <list>                      <int>
    ##  1 HoNOS            mild              <tibble [13,648 × 13]>         13
    ##  2 HoNOS            severe            <tibble [33,087 × 13]>         13
    ##  3 HoNOS            subclinical       <tibble [2,591 × 13]>          13
    ##  4 HoNOS            moderate          <tibble [15,846 × 13]>         13
    ##  5 K10              non-clinical      <tibble [8,448 × 11]>          11
    ##  6 K10              severe            <tibble [29,191 × 11]>         11
    ##  7 K10              moderate          <tibble [6,370 × 11]>          11
    ##  8 K10              mild              <tibble [5,159 × 11]>          11
    ##  9 HoNOS65          subclinical       <tibble [333 × 13]>            13
    ## 10 HoNOS65          mild              <tibble [2,416 × 13]>          13
    ## # ℹ 18 more rows

Compare that to using nested for loops in base R:

    # Initialize an empty list to store the results
    result_list <- list()

    # Loop through each assessment scale
    for (i in unique(activation_final$assessment_scale)) {
      # Get the columns to select for the current assessment scale
      cols <- scale_items$selected_cols[scale_items$assessment_scale == i][[1]]
      
      # Loop through each severity category
      for (j in unique(activation_final$severity_category)) {
        # Filter the data for the current assessment scale and severity category
        data_subset <- activation_final[activation_final$assessment_scale == i & activation_final$severity_category == j, ]

        # Select the relevant columns
        selected_data <- data_subset[, c("nocc_episode_identifier", cols), drop = FALSE]

        # Store the result in the list
        result_list[[paste(i, j, sep = ".")]] <- selected_data
      }
    }

    # Combine the results back into a single data frame
    activation_final <- do.call(rbind, result_list)

In this example, I used two levels used in the analysis. This approach
reduces the data down to the equivalent of the lowest level of nested
for loops and maintains the information about the levels of iterations
in the non-nested columns. There are definitely more HQIU-relevant use
cases where you can use more than two or more nesting columns.

For example…

`squis_core_wide %>% nest(.by = c("qsg_themes", "indicator", "hospital"))`

or

`referral_timline %>% nest(.by = c("CMHI", "access_episode", "mh_stream"))`
