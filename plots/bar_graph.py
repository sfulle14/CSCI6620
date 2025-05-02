import matplotlib.pyplot as plt
import numpy as np

# Data sets
SQL_rows = ['1000','10000','100000', 'All']
SQL_times = [128, 729, 5966, 354]

SSIS_rows = ['1000','10000','100000', 'All']
SSIS_times = [139,730,6143,385]

Python_rows = ['1000','10000','100000', 'All']
Python_times = [128.25, 759.72, 5926.76, 372.99]

Max_runs = ['SQL', 'SSIS', 'Python']
Max_times = [354, 385, 372.99]

runs_1000 = ['SQL', 'SSIS', 'Python']
times_1000 = [128, 139, 128.25]

runs_10000 = ['SQL', 'SSIS', 'Python']
times_10000 = [729, 730, 759.72]

runs_100000 = ['SQL', 'SSIS', 'Python']
times_100000 = [5966, 6143, 5926.76]

runs_all = ['SQL', 'SSIS', 'Python']
times_all = [354, 385, 372.99]


# Plots
# plt.bar(SQL_rows, SQL_times)
# plt.title("SQL run times")
# plt.xlabel("Run sizes")
# plt.ylabel("Times (s)")
# plt.show()

# plt.bar(SSIS_rows, SSIS_times)
# plt.title("SSIS run times")
# plt.xlabel("Run sizes")
# plt.ylabel("Times (s)")
# plt.show()

# plt.bar(Python_rows, Python_times)
# plt.title("Python run times")
# plt.xlabel("Run sizes")
# plt.ylabel("Times (s)")
# plt.show()

# plt.plot(Max_runs, Max_times, marker='o', linestyle='-')
# plt.title("Max data run times")
# plt.xlabel("Run types")
# plt.ylabel("Times (s)")
# plt.ylim(bottom=0, top=500)
# plt.show()

# plt.plot(SQL_rows, SQL_times, marker='o', linestyle='-', color='red', label='SQL')
# plt.plot(SSIS_rows, SSIS_times, marker='o', linestyle='-', color='blue', label='SSIS')
# plt.plot(Python_rows, Python_times, marker='o', linestyle='-', color='green', label='Python')
# plt.title("All data run times")
# plt.legend()
# plt.xlabel("Run types")
# plt.ylabel("Times (s)")
# plt.show()

# plt.bar(runs_1000, times_1000)
# plt.title("1000 row run times")
# plt.xlabel("Run sizes")
# plt.ylabel("Times (s)")
# plt.show()

# plt.bar(runs_10000, times_10000)
# plt.title("10000 row run times")
# plt.xlabel("Run sizes")
# plt.ylabel("Times (s)")
# plt.show()

# plt.bar(runs_100000, times_100000)
# plt.title("100000 row run times")
# plt.xlabel("Run sizes")
# plt.ylabel("Times (s)")
# plt.show()

plt.bar(runs_100000, times_100000)
plt.title("All rows run times")
plt.xlabel("Run sizes")
plt.ylabel("Times (s)")
plt.show()