# meetup-analytics
A script to get the most popular meet ups for a set of topics in a number of cities

## Usage

1. Create a file `topics.txt` with a list (line-break separated) of topics you want to track
2. Create a file `locations.txt` with a list of cities you want to track
3. Get your API key from meetup.com
4. Run the script

## Running

```
$ chmod +x meetup.sh
$ ./meetup.sh <your-meetup-api-key>
```

The script will generate a TSV output that can be opened by Excel. It might make sense to redirect the output into a file:

```
$ ./meetup.sh <your-meetup-api-key> > meetups.csv
```
