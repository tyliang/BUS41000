## Business Statistics, Spring 2018

### Instructor
[Tengyuan Liang](http://faculty.chicagobooth.edu/Tengyuan.Liang/)

### Syllabus
[Syllabus](Syllabus.pdf)

### Lecture Notes

[Section 1](Lecture/Section1.pdf)

[Section 2](Lecture/Section2.pdf)

[Section 3](Lecture/Section3.pdf)

[Section 4](Lecture/Section4.pdf)

[Section 5](Lecture/Section5.pdf)

### Practice Exam

[Practice Midterm](Homework/practice_midterm.pdf), [Practice Solution](Homework/practice_midterm_solution.pdf)

[Spring Midterm Solution](Homework/spring18_midterm_solution.pdf)

### Homework

[Homework 1](Homework/HW1.pdf), [Solution 1](Homework/HW1_sol.pdf)

[Homework 2](Homework/HW2.pdf), [Solution 2](Homework/HW2_sol.pdf), [Solution Q1 and Q2 in R](Homework/HW2-TA.pdf), [Q1 in Excel](Homework/Question1.xlsx), [Q2 in Excel](Homework/Question2.xlsx)

[Homework 3](Homework/HW3.pdf), [Solution 3](Homework/HW3_sol.pdf)

[Homework 4](Homework/HW4.pdf), [Solution 4](Homework/HW4_sol.pdf)

Questions about the homework can be posted to Canvas Discussion section. TAs will answer
them within 24-48 hrs during weekdays. Homework does not count towards the final grade, but I strongly recommend everyone to do *all the homework*.


### Datasets

[Shock Absorber Data](Datasets/shock.csv)

[Apple, Intel, Safeway Data](Datasets/Apple_Intel_Safeway.xls)

[Profits](Datasets/Profits.csv)

[Zagat](Datasets/zagat.csv)

[Baseball](Datasets/RunsPerGame.csv)

[Orion Bus](Datasets/Orion.xls)

[Beauty](Datasets/BeautyData.csv)

[Mid City](Datasets/MidCity.csv)

[Salary Data](Datasets/SalaryData.xls)

[S&P 500 cleaned](Datasets/SP500.csv)



### R Scripts (optional)
[*SLR and MLR*](Lecture/Apple_Intel_Safeway.html)

[*Annual Return*](Lecture/AnnualReturn.html)

[*Stock Hedge*](Lecture/StockHedge.html)

[Section 1](Rscript/Section1.R)

[Section 2](Rscript/Section2.R)

[Section 3](Rscript/Section3.R)

[Section 4](Rscript/Section4.R)

<!-- [Section 5](Rscript/Section5.R) -->


### Other Fun Statistics

[FiveThirtyEight article](http://fivethirtyeight.com/features/why-fivethirtyeight-gave-trump-a-better-chance-than-almost-anyone-else/)

Simpson's Paradox: [video](https://www.youtube.com/watch?v=ebEkn-BiW5k), [article](http://vudlab.com/simpsons/)

Guessing Correlation: [wiki](https://en.wikipedia.org/wiki/Guess_the_Correlation), [game](http://guessthecorrelation.com/)

[Spurious Correlation](http://www.tylervigen.com/spurious-correlations)

[Demonstration of Normal Approximation/CLT](https://gallery.shinyapps.io/CLT_mean/)

[Demonstration of Confidence Interval](https://shiny.rit.albany.edu/stat/confidence/)

[Chicago Booth Review Article](http://review.chicagobooth.edu/economics/2016/video/why-cant-we-close-gender-gap)

[AI? Not yet](https://medium.com/@mijordan3/artificial-intelligence-the-revolution-hasnt-happened-yet-5e1d5812e1e7)

[XKCD, hypothesis testing, can you get the point?](https://xkcd.com/882/)

[Moneyball](https://www.youtube.com/watch?v=yGf6LNWY9AI)

[Simple Linear Regression App, play!](https://gallery.shinyapps.io/simple_regression/)

Acknowledgement: Thanks to Dr. Carlos Carvalho for sharing many materials.

<!-- You can use the [editor on GitHub](https://github.com/tyliang/BUS41000/edit/master/README.md) to maintain and preview the content for your website in Markdown files.

Whenever you commit to this repository, GitHub Pages will run [Jekyll](https://jekyllrb.com/) to rebuild the pages in your site, from the content in your Markdown files.

### Markdown

Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

```r
# Generate 5000 worlds, each simulate 20 years
returns = matrix(rnorm(n = 5000*20, mean = 6, sd = 15),
                 nrow = 5000, ncol=20)/100
total_wealth = apply(1+returns, 1, prod)
# Plotting
d = density(total_wealth)
plot(d, xlab="total wealth in $", ylab = "density",
      main = "Total wealth in 20 years", xlim = c(0,20))
abline(v = mean(total_wealth), col = 'red', lty=2)
abline(v = median(total_wealth), col = 'blue', lty=2)
legend("topright",
  legend = c(paste("mean ", round(mean(total_wealth),2)),
        paste("median ", round(median(total_wealth),2))),
       col = c('red', 'blue'), lty = c(2,2))
```


For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/tyliang/BUS41000/settings). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://help.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out. -->
