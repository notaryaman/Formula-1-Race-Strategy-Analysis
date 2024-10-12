# Formula 1 Race Strategy Analysis

This project analyzes Formula 1 race strategies using machine learning to predict the effects of different race parameters (such as starting position, number of laps, and pit stops) on a driver's race outcome. It provides a user-friendly interface using Streamlit to simulate and optimize race strategies for better results.


## Requirements

Make sure to install the required Python packages before running the project:

```bash
pip install pandas numpy scikit-learn streamlit matplotlib

```
## How to run the project
### Step 1: Fetch Race Data
Run ```fetch_data.py``` to download raw race data
```bash
python C:/Users/singh/src/fetch_data.py
```

### Step 2: Preprocess the Data
Run ```preprocess.py``` to clean the raw data:
```bash
python C:/Users/singh/src/preprocess.py
```
### Step 3: Train the Model
Train the machine learning model using ```model.py```:
```bash
python C:/Users/singh/src/model.py
```

### Step 4: Run the Streamlit App
Start the Streamlit app for user interaction:
```bash
streamlit run C:/Users/singh/app.py
```

## Example Commands 
Here are the commands as used during the setup:
```bash
(base) PS C:\Users\singh> python C:/Users/singh/src/model.py
(base) PS C:\Users\singh> python C:/Users/singh/src/preprocess.py
(base) PS C:\Users\singh> streamlit run C:/Users/singh/app.py
```

## Features:
* Predict Race Outcomes: Use a trained model to predict a driver's final position based on starting grid position, laps, and pit stops.
* Compare Strategies: See how different pit stop strategies affect race outcomes.
* Interactive UI: Adjust race parameters through a Streamlit interface and see the results in real-time.
* Improvement Suggestions: Get actionable feedback on what changes could improve a driver's chances of winning the race.

## Data Source
  The project uses [Ergast Motor Racing Data API](https://ergast.com/mrd/) to fetch historical formula 1 data

## Dependencies:
- pandas
- numpy
- scikit-learn
- streamlit
- matplotlib

## Credit and What I learned:
This project was developed with the guidance of OpenAI's ChatGPT, which provided educational insights into the process of training and evaluating a machine learning model. The assistance helped me better understand the following aspects:

**Training the Model**: Gained a deeper understanding of using a Random Forest model for predicting race outcomes based on features like starting grid position, laps, and pit stops.

**Data Preprocessing**: Learned how to clean and prepare data for machine learning, including handling missing values and creating new features like position change.

This collaboration was purely from an educational standpoint, helping me grasp key concepts in data analysis and machine learning
