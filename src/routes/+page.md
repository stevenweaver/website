<script>
  import Hero from '$lib/components/Hero.svelte';
</script>

<Hero />

<section class="bio">

<div class="bio-photo">

![Steven Weaver](/s2.jpg)

</div>

<div class="bio-text">

## About

I'm a Senior Programming Analyst at Temple University's Institute for Genomics
and Evolutionary Medicine ([CV](https://www.stevenweaver.org/cv/)). I develop and
maintain bioinformatics software for analyzing molecular evolution and natural
selection in pathogen genomes. This includes [Datamonkey](https://datamonkey.org)
and the [HyPhy](https://hyphy.org) platform for selection analysis, the
phylotree.js visualization library, and HIV-TRACE, a tool for molecular
epidemiology. The software is written primarily in C++, Python, and JavaScript.

Beyond building these tools, I conduct research on the molecular epidemiology of
viral pathogens, including HIV and hepatitis C, using genetic-distance methods to
reconstruct transmission networks. I develop and maintain the systems that
public-health agencies, including the U.S. Centers for Disease Control and
Prevention, use for HIV molecular surveillance and cluster detection. During the
COVID-19 pandemic, I also contributed to the characterization of SARS-CoV-2,
including its variants of concern and the Omicron lineages.

These analyses run at scale on high-performance computing, which I provision and
administer at the San Diego Supercomputer Center and at Temple University.

Current work is focused on modernizing the platform: compiling HyPhy to
WebAssembly so that selection analyses can run directly in a web browser, and
connecting the analysis platform to large language models through the Model
Context Protocol.

</div>

</section>

<style>
  .bio {
    display: grid;
    grid-template-columns: 200px 1fr;
    gap: var(--space-8);
    align-items: start;
    margin-top: var(--space-8);
  }

  .bio-photo :global(img) {
    border-radius: 50%;
    width: 200px;
    height: 200px;
    object-fit: cover;
  }

  .bio-text :global(h2:first-child) {
    margin-top: 0;
  }

  @media (max-width: 640px) {
    .bio {
      grid-template-columns: 1fr;
      justify-items: start;
      gap: var(--space-4);
    }
  }
</style>
