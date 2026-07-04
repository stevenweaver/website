# Running HyPhy Analyses with Datamonkey MCP on Claude Cowork

<p class="dateline">Published May 2026</p>

## Introduction

[Datamonkey](https://datamonkey.org) is a web application for evolutionary analysis powered by [HyPhy](https://hyphy.org). Traditionally, running selection analyses requires either installing HyPhy locally or navigating the Datamonkey web interface manually. With the Datamonkey MCP (Model Context Protocol) server, you can now run these analyses directly through a conversational interface in [Claude Cowork](https://claude.ai).

This tutorial walks through connecting the Datamonkey MCP server to Claude Cowork and running a RELAX analysis on a CD2 (cluster of differentiation 2) dataset to test for relaxed selection in rodent lineages relative to primates.

## Prerequisites

- A [Claude](https://claude.ai) account with access to Cowork
- A codon-aware alignment file in FASTA format (we will use a CD2 slim dataset)

## Step 1: Add the Datamonkey Connector

Navigate to **Settings > Connectors** in Claude Cowork. Click **Add custom connector** and fill in the following:

- **Name**: `Datamonkey`
- **URL**: `https://mcp.datamonkey.org/mcp`

Click **Add** to install the connector.

![Adding the Datamonkey MCP connector in Claude Cowork settings](/assets/datamonkey-mcp/add-connector.png)

## Step 2: Configure Tool Permissions

After adding the connector, click **Configure** next to the Datamonkey entry to review its available tools:

- **cancel_job** — Cancel a running or queued job
- **get_job_results** — Retrieve results of a completed job
- **get_job_status** — Query the current status of a job
- **list_analyses** — List all available HyPhy analysis types
- **spawn_analysis** — Submit a new analysis job
- **validate_alignment** — Pre-flight check on alignment format and codons

Set the permission level to **Always allow** if you want Claude to run analyses without prompting for approval on each tool call, or leave the default to approve individually.

![Datamonkey tool permissions configuration](/assets/datamonkey-mcp/tool-permissions.png)

## Step 3: Create a New Cowork Project

Switch to the **Cowork** tab and create a new project. Select **Start from scratch** to set up a new folder with instructions and files.

![Creating a new Cowork project](/assets/datamonkey-mcp/create-project.png)

## Step 4: Set Up Your Project

Give your project a name (e.g., `Datamonkey`) and attach your alignment file. In this tutorial, we add `CD2-slim.fna`, a small codon alignment of the CD2 gene across several mammalian species. Choose a project location on your machine and click **Create**.

![Configuring the new project with an alignment file](/assets/datamonkey-mcp/start-project.png)

## Step 5: Run an Analysis

With the project created and your alignment file available, simply ask Claude to run an analysis. For example:

> I would like to run RELAX on the CD2 dataset that is already provided in this project.

Claude will:

1. **Read the alignment** and identify the species present (e.g., Human, Chimp, Baboon, RhMonkey, Cow, Pig, Horse, Cat, Mouse, Rat)
2. **Determine branch labeling** — RELAX requires designating **test** and **reference** branches on the phylogeny. Claude will ask which branches should be labeled as the test group.
3. **Validate the alignment** using the `validate_alignment` tool to check for format issues, stop codons, and codon frame correctness.

In this example, we designate **rodents** (Mouse, Rat) as the test group and **primates** (Human, Chimp, Baboon, RhMonkey) as the reference group.

![Claude identifying branches and asking about test/reference group assignment](/assets/datamonkey-mcp/relax-branches.png)

## Step 6: Monitor Progress

After you confirm the branch assignments, Claude will:

1. Prepare the labeled Newick tree following HyPhy's convention — `{Test}` for rodent branches and `{Reference}` for primate branches
2. Validate the alignment against the analysis parameters
3. Submit the RELAX job via `spawn_analysis`
4. Poll the job status with `get_job_status` until the run completes

You can watch all of this happening in real time in the Cowork conversation. The progress panel on the right side of the screen also tracks each step.

![Claude running the RELAX analysis — tree labeling, validation, and job submission](/assets/datamonkey-mcp/relax-running.png)

## Step 7: Interpret Results

Once the analysis completes, Claude fetches the full results using `get_job_results` and provides a plain-language summary. For the CD2 dataset, the RELAX analysis found:

- **Significant evidence of relaxed selection** on rodent (Test) branches relative to primate (Reference) branches (*p* = 0.018, LRT = 5.59)
- The relaxation parameter **K = 0.009**, well below 1, indicating that selection pressures on rodent branches are substantially relaxed compared to primates
- Under the alternative model, **reference** (primate) branches showed strong contrast between purifying selection (&omega; = 0.017–0.019, ~96% of sites) and a small class under very strong diversifying selection (&omega; = 3.10–13.95)
- **Test** (rodent) branches had more moderate values (&omega; = 0.73 for the purifying class, &omega; = 1.34 for the diversifying class), consistent with relaxation pulling everything toward neutrality
- The analysis flagged 2 duplicate sequences (Human/Chimp and Baboon/RhMonkey), which is expected given the slim 17-codon dataset

![RELAX analysis results showing significant relaxed selection on rodent branches](/assets/datamonkey-mcp/relax-results.png)

## Available Analyses

The Datamonkey MCP server supports a wide range of HyPhy methods beyond RELAX, including:

| Method | Description |
|--------|-------------|
| **aBSREL** | Adaptive branch-site random effects likelihood — tests for episodic diversifying selection on individual branches |
| **BUSTED** | Branch-site unrestricted statistical test for episodic diversification — tests whether a gene has experienced positive selection |
| **FEL** | Fixed effects likelihood — tests for selection at individual sites |
| **MEME** | Mixed effects model of evolution — detects episodic positive selection at sites |
| **SLAC** | Single-likelihood ancestor counting — a fast, conservative site-level selection test |
| **FUBAR** | Fast unconstrained Bayesian approximation — Bayesian site-level selection analysis |
| **GARD** | Genetic algorithm for recombination detection — screens alignments for recombination breakpoints |
| **CFEL** | Contrast-FEL — tests for differences in selective pressures between groups of branches at individual sites |
| **BGM** | Bayesian graphical model — identifies coevolving sites |
| **FADE** | FUBAR approach to directional evolution — detects directional selection at sites along specified branches |
| **PRIME** | Property informed models of evolution — identifies selection at sites driven by changes in amino acid properties |

You can ask Claude to list all available analyses and their parameters at any time by saying something like "What analyses can I run with Datamonkey?"

## Tips

- **Natural language is sufficient.** You don't need to know HyPhy command-line syntax. Just describe what you want to test and Claude will handle parameter selection and job configuration.
- **Attach multiple files.** You can add several alignments to a project and run different analyses across them in the same conversation.
- **Ask follow-up questions.** After receiving results, ask Claude to explain specific values, compare across analyses, or suggest next steps.
- **Iterative workflows.** You can chain analyses together — for example, run GARD first to check for recombination, then run site-level methods on the resulting partitions.
