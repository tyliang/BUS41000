## Business Statistics, Spring 2018

### Instructor
[Tengyuan Liang](http://faculty.chicagobooth.edu/Tengyuan.Liang/)

### Syllabus
[Syllabus](Syllabus.pdf)

### Lecture Notes

[Section 1](Lecture/Section1.pdf)

[Section 2](Lecture/Section2.pdf)

You can use the [editor on GitHub](https://github.com/tyliang/BUS41000/edit/master/README.md) to maintain and preview the content for your website in Markdown files.

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
```
```r
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

Having trouble with Pages? Check out our [documentation](https://help.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.
