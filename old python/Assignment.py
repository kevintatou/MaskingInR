import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

dtype = np.float64


# Euclidean distance
def distance_euclidean(record1, record2):
    return np.sqrt(np.sum(record1 - record2) * (record1 - record2))


# Distance-based record linkage
def db_rl(original_data, masked_data):
    i = 1
    re_identified = 0

    while i <= len(original_data) - 1:
        j = 0
        min_dist = 100000
        min_record = 1
        masked_length = len(masked_data) - 1
        while j <= masked_length:
            if distance_euclidean(original_data[i, ], original_data[j, ]) < min_dist:
                min_dist = distance_euclidean(original_data[i, ], original_data[j, ])
                min_record = j
            j += 1
        if min_record == i:
            re_identified += 1
        i += 1
    return re_identified


def normalize_data(normalized_list):
    normalized_list_data = []
    for micro in normalized_list:
        subtract_mean_micro = micro_data_list_mean - micro
        normalized_list_data.append(subtract_mean_micro / standard_deviation)
    return normalized_list_data


micro_data = pd.read_excel('CASCrefmicrodata.xls', 0, usecols=[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])

micro_data_list_col = micro_data.values

micro_data_list_mean = np.mean(micro_data_list_col)  # Mean of original data
standard_deviation = np.std(micro_data_list_col)  # Standard deviation of original data

# Normalized data
normalized_without_noise = [normalize_data(micro_data_list_col)]
mean_normalized = np.mean(normalized_without_noise)
standard_deviation_normalized = np.std(normalized_without_noise)

number_of_variables = 13


for soon_to_be_masked in normalized_without_noise:
    for mask_to_file in range(5):  # Uncomment when done with RU Map
        noise = np.random.normal(mean_normalized, standard_deviation_normalized,number_of_variables)
        masked = soon_to_be_masked + noise  # loop through a full list 5 times to and get a file for each time
        if mask_to_file >= 1:
            masked = masked + noise  # Create masked according to previous masked with some more noise.
        cas_ref_micro_data = pd.DataFrame(masked)
        cas_ref_micro_data.to_excel('CASCrefmicrodata.' + str(mask_to_file) +'.xlsx')

        disclosure_risk = db_rl(normalized_without_noise, masked)  # put in loop

        information_loss = (normalized_without_noise - masked) ** 2 / mean_normalized # put in loop

        for il in information_loss[0][0]:
            plt.scatter(x= disclosure_risk, y= il)
        plt.xlabel('x')
        plt.ylabel('y')
        plt.show()
           # print(il)
            #print(disclosure_risk)  # 0, does this mean that the risk does not exist, so then information loss must be high???
