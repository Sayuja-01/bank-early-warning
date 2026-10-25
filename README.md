# Bank Early-Warning Monitor

**Could public bank data have flagged the 2023 bank failures early?**
An Alteryx + SAS pipeline that screens every large US bank on four warning signs, backtested on the failures of Silicon Valley Bank, Signature Bank and First Republic.

**Live demo:** [Bank Early-Warning Monitor](LINK_TO_LIVE_DEMO), with a playable "examiner" game, a scroll-driven data story, a watchlist and a bank lookup.


\*\*Memo:\*\* \[Findings and recommendations](docs/memo.md)

\---

## Key findings

Using only Call Report data for 31 December 2022, ten weeks before SVB failed:

* **SVB ranked #1 of 158 US banks with more than $10 billion in assets** on the combined risk score (94.9 out of 100), clearly ahead of every other bank.
* **SVB was in the top 10% of its peer group on all four warning signs**: 94% of deposits uninsured, hidden bond losses equal to 98% of its equity, 56% of assets in bonds, and deposits up 70% in two years.
* **The traditional capital check flagged none of the three failed banks.** Their equity ratios (7–8% of assets) were unremarkable compared with their peers.
* **Signature and First Republic ranked #24 and #25 of 158**: elevated, but not at the top. Signature stood out on uninsured deposits (91st percentile among the largest banks). First Republic's main weakness, low-rate mortgages, isn't captured by these bond-based indicators.
* **Hidden losses alone didn't cause a run.** Charles Schwab's banks and USAA had bond losses even larger than their equity, but their depositors were mostly insured. SVB was the only large bank where big losses met money that could leave.
* **The screen has false positives, as any screen does.** Several high-scoring banks survived, including custody banks and Hawaii's regional banks, whose deposits behave differently from what the numbers suggest.

The same pipeline, run on 30 June 2026 data, produces a current watchlist. A high score means a bank *stands out* on these indicators, not that it will fail.

\---

## How it works

```
FFIEC Call Report bulk files (4 quarters)
        │
        ▼
  Alteryx: build the bank × quarter panel
   • read 5 schedules per quarter (POR, RC, RC-B, RC-O)
   • remove description rows, join by bank ID (IDRSSD)
   • merge RCFD (consolidated) and RCON (domestic) reporting forms
   • calculate indicators and 2-year deposit growth
        │
        ▼
  SAS: peer screen
   • group banks by size ($1–10B, $10–100B, $100B+)
   • percentile-rank each indicator within peer group and quarter
   • flag top 10% (bottom 10% for equity)
   • combined risk score = average of four warning-sign ranks
        │
        ▼
  Web monitor: game, story, backtest, watchlist, lookup
```

### Indicators

|Indicator|Formula (Call Report fields)|What it catches|
|-|-|-|
|Uninsured deposit share|RCON5597 ÷ RCON2200|Run risk: money above the $250,000 insurance limit|
|Hidden bond losses vs. equity|(HTM cost 1754 − HTM fair value 1771) ÷ equity 3210|Losses on held-to-maturity bonds that don't reduce reported capital|
|Securities vs. assets|(1754 + AFS fair value 1773) ÷ total assets 2170|Exposure to falling bond prices|
|Two-year deposit growth|RCON2200 now ÷ 8 quarters earlier − 1|Fast, concentrated, flighty funding|
|Equity vs. assets *(traditional check)*|3210 ÷ 2170|The bank's own cushion; shown for comparison, not in the score|

Banks filing the FFIEC 031 form (with foreign offices) report many items with an RCFD prefix; others use RCON. The workflow uses RCFD where filled in, otherwise RCON.

\---

## Data

* **Source:** [FFIEC Central Data Repository](https://cdr.ffiec.gov/public/PWS/DownloadBulkData.aspx), Call Reports, Single Period, tab-delimited.
* **Quarters used:** 31 Dec 2020 and 31 Dec 2022 (backtest), 30 Jun 2024 and 30 Jun 2026 (current watchlist).
* **Coverage:** 4,756 banks at 31 Dec 2022 and 4,297 at 30 Jun 2026. The screen covers banks with $1 billion or more in assets (about 1,000 per quarter), because smaller banks don't report the uninsured deposit estimate.
* Raw data isn't stored in this repo (around 500 MB per quarter). See *Reproduce it* below.

\---

## Repository structure

```
alteryx/
  bank\\\_panel.yxmd            Alteryx workflow, 31 Dec 2022 (with 2020 for growth)
  bank\\\_panel\\\_20260630.yxmd   Same workflow, 30 Jun 2026 (with 2024 for growth)
sas/
  peer\\\_screen.sas            Size groups, percentile ranks, flags, risk score, watchlists
data/
  raw/                       FFIEC downloads (not committed)
  clean/                     Alteryx and SAS outputs (not committed)
docs/                        Memo and notes
```

\---

## Reproduce it

1. Download the four quarters from the FFIEC bulk download page (Call Reports – Single Period, Tab Delimited) and unzip each into its own folder in `data/raw/`.
2. Open `alteryx/bank\\\_panel.yxmd` in Alteryx Designer and run it. It writes `data/clean/panel\\\_20221231.csv`. Then run `bank\\\_panel\\\_20260630.yxmd` for `panel\\\_20260630.csv`.
3. Upload both CSVs to SAS (for example SAS OnDemand for Academics), set the `path` macro variable in `sas/peer\\\_screen.sas`, and run it. It writes `scored\\\_banks.csv`.

\---

## Limitations

* **Bonds, not loans:** the indicators capture interest-rate risk in securities, not in loan books (First Republic's main exposure).
* **False positives:** deposit stickiness, local customer bases and business models such as custody banking aren't visible in these numbers.
* **Definitional quirk:** for a few custody banks, estimated uninsured deposits slightly exceed reported US-office deposits (a share just above 100%), likely due to differences between the two reported items. Rankings are unaffected.
* **Small top peer group:** only about 33 banks have more than $100 billion in assets, so each percentile step there is roughly three points.
* **Hindsight:** indicators were chosen knowing how 2023 unfolded. The 2026 watchlist is the out-of-sample test.

This is an analytical portfolio project, not investment or supervisory advice.

\---

## Tools

Alteryx Designer, SAS (PROC IMPORT, RANK, MEANS, FREQ), HTML and JavaScript, Git

**Author:** Sayuja Kute, MS in Analytics, Northeastern University. [Portfolio](https://sayujakute.vercel.app)

