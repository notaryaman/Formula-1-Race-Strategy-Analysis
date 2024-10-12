import streamlit as st
import pandas as pd
import numpy as np
import pickle
import matplotlib.pyplot as plt

def load_model():
    with open('data/race_strategy_model.pkl', 'rb') as file:
        model = pickle.load(file)
    return model

def predict_position_change(model, grid, laps, pit_stop_count):
    # Create a DataFrame for the input features
    input_data = pd.DataFrame([[grid, laps, pit_stop_count]], columns=['grid', 'laps', 'pit_stop_count'])
    # Make the prediction
    prediction = model.predict(input_data)[0]
    return prediction

def find_win_strategy(model, grid, laps):
    # Define a range of possible pit stops to find the best strategy
    strategies = []
    
    for pit_stop_count in range(1, 5):  # Assuming up to 4 pit stops
        position_change = predict_position_change(model, grid, laps, pit_stop_count)
        final_position = grid - position_change
        strategies.append({
            'pit_stop_count': pit_stop_count,
            'position_change': position_change,
            'final_position': final_position
        })
    
    # Find the strategy that results in the best final position
    best_strategy = min(strategies, key=lambda x: x['final_position'])
    return strategies, best_strategy

def plot_strategies(strategies, grid):
    df = pd.DataFrame(strategies)
    plt.figure(figsize=(8, 4))
    plt.plot(df['pit_stop_count'], df['final_position'], marker='o', linestyle='-', color='blue', label='Final Position')
    plt.axhline(y=1, color='green', linestyle='--', label='1st Place Threshold')
    plt.title(f"Effect of Pit Stops on Final Position (Starting Position: {grid})")
    plt.xlabel("Number of Pit Stops")
    plt.ylabel("Predicted Final Position")
    plt.xticks(np.arange(1, 5))
    plt.gca().invert_yaxis()  # Invert y-axis because lower numbers are better positions
    plt.legend()
    plt.grid(True)
    st.pyplot(plt)

def provide_recommendation(best_strategy, grid):
    if best_strategy['final_position'] == 1:
        return "The current strategy is already optimal for winning."
    
    if best_strategy['final_position'] <= 3:
        if best_strategy['pit_stop_count'] > 1:
            return f"To potentially secure a win, try reducing the number of pit stops to {max(1, best_strategy['pit_stop_count'] - 1)} while maintaining aggressive lap times."
        else:
            return "To improve chances for a win, consider more aggressive tire strategies or optimizing pit stop timings."
    
    if best_strategy['final_position'] > 1:
        suggestion = f"Currently, the driver is predicted to finish in {int(best_strategy['final_position'])}th place. "
        if best_strategy['pit_stop_count'] > 1:
            suggestion += f"Try reducing the number of pit stops to {best_strategy['pit_stop_count'] - 1} for a potential gain in positions."
        else:
            suggestion += "Consider adjusting the pit stop strategy or using a different tire choice to gain a competitive edge."
        return suggestion

if __name__ == "__main__":
    st.title("🏎️ Formula 1 Race Strategy Predictor")
    st.markdown("Use this tool to analyze the best pit stop strategy for a Formula 1 race and see if your driver can reach the podium!")

    # User inputs for race parameters
    st.sidebar.header("Race Settings")
    grid = st.sidebar.slider('Starting Grid Position', 1, 20, 10)
    laps = st.sidebar.slider('Total Laps', 1, 70, 50)
    
    # Load the trained model
    model = load_model()

    # Analyze strategies and find the best one
    strategies, best_strategy = find_win_strategy(model, grid, laps)
    
    # Display the best strategy
    st.subheader(f"Best Strategy for Starting Position {grid} with {laps} Laps")
    st.write(f"**Number of Pit Stops:** {best_strategy['pit_stop_count']}")
    st.write(f"**Predicted Position Change:** {best_strategy['position_change']}")
    st.write(f"**Predicted Final Position:** {best_strategy['final_position']}")
    
    # Provide specific recommendations for improvement
    recommendation = provide_recommendation(best_strategy, grid)
    st.markdown(f"### Recommendation: {recommendation}")
    
    if best_strategy['final_position'] == 1:
        st.success("🎉 This strategy could help the driver win the race!")
    elif best_strategy['final_position'] <= 3:
        st.info("🏆 This strategy could secure a podium finish!")
    else:
        st.warning("🤔 The driver is unlikely to finish 1st with this strategy.")

    # Compare all strategies visually
    st.subheader("Compare Different Pit Stop Strategies")
    plot_strategies(strategies, grid)
    
    # Display a table of strategies
    st.markdown("### Strategy Comparison")
    strategy_df = pd.DataFrame(strategies)
    strategy_df.columns = ['Pit Stops', 'Predicted Position Change', 'Predicted Final Position']
    st.table(strategy_df)

    st.markdown("### Customize Your Strategy")
    st.markdown("Want to test your own pit stop strategy?")
    
    custom_pit_stops = st.slider('Choose a custom number of pit stops', 1, 5, 2)
    custom_position_change = predict_position_change(model, grid, laps, custom_pit_stops)
    custom_final_position = grid - custom_position_change

    st.write(f"With **{custom_pit_stops} pit stops**, the driver is predicted to have a position change of **{custom_position_change:.2f}** and finish in position **{custom_final_position:.2f}**.")

    if custom_final_position == 1:
        st.success("🎉 This custom strategy could lead to a win!")
    elif custom_final_position <= 3:
        st.info("🏆 This custom strategy could secure a podium finish!")
    else:
        st.warning("🤔 This custom strategy may not lead to a win.")
