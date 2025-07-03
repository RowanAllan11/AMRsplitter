import pandas as pd
import sys

# Per sample AMR summary input.
files = sys.argv[1:]
dfs = []

for f in files:
    df = pd.read_csv(f)
    dfs.append(df)
if dfs:
    pd.concat(dfs).to_csv("results/combined_amr_summary.csv", index=False)
    print("Combined summary saved to results/combined_amr_summary.csv")
else:
    print("No summary files found.")

