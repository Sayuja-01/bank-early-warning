/* ============================================
   Bank early-warning: peer screen
   Step 1: load and stack both quarters
   ============================================ */
options validvarname=v7;
%let path = ~/bank_ew;

proc import datafile="&path/panel_20221231.csv"
    out=work.p2022 dbms=csv replace;
    guessingrows=max;
run;

proc import datafile="&path/panel_20260630.csv"
    out=work.p2026 dbms=csv replace;
    guessingrows=max;
run;

data work.panel;
    length Financial_Institution_Name $ 120;
    set work.p2022 work.p2026;
run;

proc freq data=work.panel;
    tables report_date failed_2023;
run;

/* ============================================
   Step 2: assign each bank to a size group
   ============================================ */
data work.panel;
    set work.panel;
    length size_group $ 14;
    if      total_assets < 1000000   then size_group = "1: Under 1B";
    else if total_assets < 10000000  then size_group = "2: 1-10B";
    else if total_assets < 100000000 then size_group = "3: 10-100B";
    else                                  size_group = "4: 100B+";
run;

proc freq data=work.panel;
    tables report_date * size_group / norow nocol nopercent;
run;

proc means data=work.panel n median p90 maxdec=3;
       where report_date = '31DEC2022'd;
    class size_group;
    var uninsured_share hidden_loss_to_equity securities_to_assets
        deposit_growth_2y equity_to_assets;
run;