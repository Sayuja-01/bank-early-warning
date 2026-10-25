# Memo: What the 2023 bank failures teach us about early warning

**To:** Head of Risk Analytics, regional bank (illustrative audience)
**From:** Sayuja Kute, Analytics
**Date:** October 2026
**Re:** Backtest of a public-data early-warning screen, and a current watchlist

---

## Bottom line

A screen built only from public quarterly filings ranked **Silicon Valley Bank first of 158 large US banks** on its last report before it failed. The traditional capital check flagged **none** of the three banks that failed in 2023. Funding and interest-rate indicators, compared against size peers, should be monitored alongside capital, and the combination of hidden losses with uninsured deposits deserves its own alert.

---

## What we tested

Using Call Report data for 31 December 2022, ten weeks before SVB failed, every bank with $1 billion or more in assets was ranked against banks of a similar size on four warning signs:

| Warning sign | What it measures |
|---|---|
| Uninsured deposits | Share of deposits above the $250,000 insurance limit, the money most likely to run |
| Hidden bond losses vs. equity | Losses on held-to-maturity bonds that don't reduce reported capital |
| Bonds vs. assets | How exposed the balance sheet is to falling bond prices |
| Two-year deposit growth | How quickly funding arrived; fast money tends to leave fast |

A bank in the top 10% of its peers on a sign was flagged. The average of the four peer ranks gives a combined risk score from 0 to 100.

---

## Findings

**1. The screen put SVB at the top.** SVB scored 94.9 and ranked #1 of 158 banks with more than $10 billion in assets. It was in the top 10% of the 34 largest banks on all four signs: 94% of deposits uninsured, hidden losses equal to 98% of its equity, 56% of assets in bonds, and deposits up 70% in two years.

**2. The traditional check missed all three failures.** Equity was 7.3–8.2% of assets for SVB, Signature and First Republic, close to the typical large bank (9.2%). None was in the bottom 10% of its peers.

**3. Losses alone didn't cause a run; losses plus runnable money did.** Charles Schwab's banks and USAA had hidden bond losses even larger than their equity, but most of their depositors were insured, and none failed. SVB was the only large bank combining extreme losses with mostly uninsured deposits.

**4. The other two failures were elevated, not extreme.** Signature (#24) stood out on uninsured deposits; its run came from concentrated, crypto-related funding rather than bond losses. First Republic (#25) sat in the top quarter on three signs, but its main weakness, low-rate mortgages, isn't measured by bond-based indicators.

**5. The screen produces false positives.** Several high-scoring banks survived, including custody banks such as State Street, whose institutional deposits behave differently, and Hawaii's banks, whose local depositors are unusually stable. A high score identifies where to look, not which bank will fail.

---

## Current watchlist (30 June 2026)

Run on the latest complete quarter, the top of the list is led by UMB Bank, Citizens Business Bank, and the custody banks (State Street, BNY Mellon, Northern Trust). Hidden bond losses are much smaller than in 2022, so today's scores are driven mainly by uninsured deposits and deposit growth. Custody banks rank high by the nature of their business, which supports reviewing them as a separate peer group.

---

## Recommendations

1. **Monitor funding and rate risk alongside capital.** Add uninsured deposit share, hidden losses vs. equity, and deposit growth to routine peer monitoring. Capital ratios alone gave no warning in 2023.
2. **Create a combined alert for hidden losses plus uninsured funding.** The 2023 evidence suggests the danger is the combination; a bank flagged on both should trigger an immediate review.
3. **Compare against size peers, not the whole industry.** Large banks naturally carry more uninsured deposits; ranking within size groups avoids flagging banks simply for being big.
4. **Treat custody banks as their own peer group.** This would remove the most predictable false positives from the watchlist.
5. **Extend the screen to loan books.** Adding interest-rate risk in fixed-rate mortgages would likely have raised First Republic's score.
6. **Refresh quarterly.** The pipeline reruns on a new quarter in minutes once the files are downloaded.

---

## Limitations

The indicators were chosen knowing how 2023 unfolded, so the 2022 backtest is partly in hindsight; the 2026 watchlist is the genuine out-of-sample test. The top size group contains only about 33 banks, so percentile steps there are coarse. For a few custody banks, estimated uninsured deposits slightly exceed reported US-office deposits because the two items are defined differently; rankings are unaffected. This analysis uses public data only and is not investment or supervisory advice.

---

*Data: FFIEC Central Data Repository, Call Reports for 31 Dec 2020, 31 Dec 2022, 30 Jun 2024 and 30 Jun 2026. Pipeline: Alteryx (data preparation) and SAS (peer screen). Live demo: [sayuja-01.github.io/bank-early-warning](https://sayuja-01.github.io/bank-early-warning/).*
