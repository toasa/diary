from datetime import date, timedelta
from os import path

def daterange(start_date, end_date):
    for n in range(int((end_date - start_date).days)):
        yield start_date + timedelta(n)

def main():
    d_start = date(2022, 8, 11)
    d_end = date.today()

    count_total = 0
    count_exist = 0
    missing_diaries = []

    for d in daterange(d_start, d_end + timedelta(days=1)):
        count_total += 1

        d_path = d.strftime("%Y/%m/%d.md")
        if path.isfile(d_path):
            count_exist += 1
        else:
            missing_diaries.append(d_path)

    coverage_str = "{} / {}".format(count_exist, count_total)

    if len(missing_diaries) == 0:
        print("Fully coveraged!:", coverage_str)
    elif len(missing_diaries)  > 0:
        print("Coverage:", coverage_str)
        print("Missing :")
        for m in missing_diaries:
            print(" " + m)

main()
