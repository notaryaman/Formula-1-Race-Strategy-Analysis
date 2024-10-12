
import matplotlib.pyplot as plt
import seaborn as sns

def plot_position_change(data):
    sns.boxplot(x='position_change', y='constructor', data=data)
    plt.title('Position Change by Constructor')
    plt.show()

def plot_pit_stop_impact(data):
    sns.scatterplot(x='pit_stop_count', y='position', data=data)
    plt.title('Pit Stop Count vs Final Position')
    plt.xlabel('Pit Stop Count')
    plt.ylabel('Final Position')
    plt.show()
