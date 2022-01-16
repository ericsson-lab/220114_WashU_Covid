## Generate manifest file
## Edited 6-4-21

## import required packages 
import argparse
import csv

# Load parser
parser = argparse.ArgumentParser()

# Adding CLI arguments
parser.add_argument("-i", "--initials", help = "enter sample initials 'ZM'")
parser.add_argument("-l", "--min_sample_num", help = "minimum sample number. Ex. ZM007, enter 7")
parser.add_argument("-m", "--max_sample_num", help = "maximum sample number. Ex. ZM100, enter 100")

# Look for argumetns
args = parser.parse_args()

if args.initials:
    POOL_INITIALS = args.initials
    
if args.min_sample_num:
    MIN_SAMPLE_NUM = args.min_sample_num
    int(MIN_SAMPLE_NUM)

if args.max_sample_num:
    MAX_SAMPLE_NUM = args.max_sample_num
    int(MAX_SAMPLE_NUM)

## Do not edit SWITCH or RESET_VALUE
SWITCH = 0

#Pulls sample information and makes integers.
MIN_SAMPLE_NUM = int(MIN_SAMPLE_NUM)
MAX_SAMPLE_NUM = int(MAX_SAMPLE_NUM)

## Writing CSV file
with open('manifest.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['sample-id', 'absolute-filepath', 'direction'])
    while SWITCH == 0:
        #Handles sample num <10
        if MIN_SAMPLE_NUM < 10:
            writer.writerow([POOL_INITIALS + "00" + str(MIN_SAMPLE_NUM),
                            '$PWD/demux_seqs/' + POOL_INITIALS +'00'+ str(MIN_SAMPLE_NUM)+'_R1.fastq.gz',
                            'forward'])
            writer.writerow([POOL_INITIALS + "00" + str(MIN_SAMPLE_NUM),
                            '$PWD/demux_seqs/' + POOL_INITIALS +'00'+ str(MIN_SAMPLE_NUM)+'_R2.fastq.gz',
                            'reverse'])
        #Handles sample num 10-100
        elif MIN_SAMPLE_NUM < 100:
            writer.writerow([POOL_INITIALS + "0" + str(MIN_SAMPLE_NUM),
                            '$PWD/demux_seqs/' + POOL_INITIALS +'0'+ str(MIN_SAMPLE_NUM)+'_R1.fastq.gz',
                            'forward'])
            writer.writerow([POOL_INITIALS + "0" + str(MIN_SAMPLE_NUM),
                            '$PWD/demux_seqs/' + POOL_INITIALS +'0'+ str(MIN_SAMPLE_NUM)+'_R2.fastq.gz',
                            'reverse'])
        #Handles Sample num >100
        elif MIN_SAMPLE_NUM >= 100:
            writer.writerow([POOL_INITIALS + str(MIN_SAMPLE_NUM),
                            '$PWD/demux_seqs/' + POOL_INITIALS + str(MIN_SAMPLE_NUM)+'_R1.fastq.gz',
                            'forward'])
            writer.writerow([POOL_INITIALS + str(MIN_SAMPLE_NUM),
                            '$PWD/demux_seqs/' + POOL_INITIALS + str(MIN_SAMPLE_NUM)+'_R2.fastq.gz',
                            'reverse'])
        ## Next sample
        MIN_SAMPLE_NUM += 1
        if MIN_SAMPLE_NUM > MAX_SAMPLE_NUM:
            SWITCH = 1
