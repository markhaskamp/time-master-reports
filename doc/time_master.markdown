# TimeMachine command line app

Reads the generated csv file to generate reports


## Tasks

### Doing

- require directory as part of file cmd line option

### To Do

- print day (M,T,W,Th, ...) on client-project report
- make client-project the default report
    - especially since it's the only one
- build a --help message
    - which shows the report option values. namely client-project
- reports
    - one line per day for unique client+project
        - total hours per day

### Done

- specify input file for report
- specify src directory
    - with a default of ~/Dropbox/timemaster
- list files from src directory
- use OptionParser to get command line options

