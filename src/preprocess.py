import pandas as pd

def clean_race_data(df):
    df = df.dropna(subset=['position', 'laps'])
    df['position'] = df['position'].astype(int)
    df['grid'] = df['grid'].astype(int)
    df['laps'] = df['laps'].astype(int)
    df['position_change'] = df['grid'] - df['position']
    df['time'] = pd.to_timedelta(df['time'], errors='coerce').fillna(pd.Timedelta(0))
    return df
