# Bespoke Bayesian Biochemistry

This is the repo for my Bespoke Bayesian Biochemistry project. For rendered versions of this page and individual sections, visit [my website](https://anhosu.com/project/bayesian-biochemistry/).

I am on a quest to improve the model fitting I do on biochemical assays. For some time, I have had this feeling that I should be able to extract more information from the data gathered in biochemical assays, in particular assays with a high throughput. I have been using classical machine learning techniques and generic fitting and optimisation functions to interpret data from such assays. While this approach works, it also neglects much of the available domain expertise. Many of the underlying biochemical mechanisms are known and I would like my models to take that into account so I get results that are more directly interpretable in the context of the hypothesis that required the assay in the first place. In other words, I want a bespoke model.

Through three incremental iterations, I have built a bespoke Bayesian Model for biochemical assays that seek to quantify a dose-response. These are common assays in drug development and provide the foundation for screening as well as optimisation experiments.

## Posts in the Series

**[Bespoke Bayesian Model for Biochemical Assays](https://anhosu.com/post/bespoke-biochem-one/)**

In this, I build a Bayesian model for a single dose-response curve, representing a single experiment.


**[Bespoke Bayesian Model for High Throughput Biochemical Assays](https://anhosu.com/post/bespoke-biochem-two/)**

In this, I build a Bayesian model for a screening experiment with multiple variations of a compound.


**[Bespoke Bayesian Model for High Throughput Biochemical Assays](https://anhosu.com/post/bespoke-biochem-two/)**

Post coming soon. In this, I add upon the screening experiment, by showing how to account for batch effects and include covariates in the Bayesian model.

## License

The content of this project itself is licensed under the [Creative Commons Attribution-ShareAlike 4.0 International license](https://creativecommons.org/licenses/by-sa/4.0/), and the underlying code is licensed under the [GNU General Public License v3.0 license](LICENSE).