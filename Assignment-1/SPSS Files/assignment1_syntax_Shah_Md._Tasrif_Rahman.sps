* Encoding: UTF-8.

* Messed this one up on the first time of submission, now Imma redo allat again ah.

* Task-1 [Data importing/loading]:

GET DATA
  /TYPE=XLSX
  /FILE='E:\Statistical Softwares\SPSS\CUSPC-SPSS\Assignments\Assignment-1\week1_data.xlsx'
  /SHEET=name 'Sheet1'
  /CELLRANGE=FULL
  /READNAMES=ON
  /DATATYPEMIN PERCENTAGE=95.0
  /HIDDEN IGNORE=YES.
EXECUTE.
DATASET NAME DataSet1 WINDOW=FRONT.

* Task-2 [Data saving]:

SAVE OUTFILE='E:\Statistical Softwares\SPSS\CUSPC-SPSS\Assignments\Assignment-1\assignment1_Shah_Md._Tasrif_Rahman\assignment1_data_Shah_Md._Tasrif_Rahman.sav'
  /COMPRESSED.

* Task-3 [Defining variables]:

DATASET ACTIVATE DataSet1.
* Define Variable Properties.
*student_id.
VARIABLE LEVEL  student_id(NOMINAL).
VARIABLE LABELS  student_id 'Student identification number'.

*gender.
VARIABLE LABELS  gender 'Gender of respondent'.
VALUE LABELS gender
  '1     ' 'Male'
  '2     ' 'Female'.

* This following part is redundant since in the given dataset, the "faculty" column already has the names of the faculties, instead of numbers representing them.

*faculty.
*VARIABLE LABELS  faculty 'Faculty of enrolment'.
*VALUE LABELS faculty
  'Science'      '1'
  'Business'    '2'
  'Arts'            '3'
  'Engineering' '4'.
 
*year_of_study.
VARIABLE LEVEL  year_of_study(SCALE).
VARIABLE LABELS  year_of_study 'Current academic year'.

*study_hours_week.
VARIABLE LABELS  study_hours_week 'Self-reported study hours per week'.

*sleep_hours.
VARIABLE LABELS  sleep_hours 'Average hours of sleep per night'.

*attendance_pct.
VARIABLE LABELS  attendance_pct 'Class attendance (percentage)'.

*stress1.
VARIABLE LEVEL  stress1(ORDINAL).
VARIABLE LABELS  stress1 'I feel overwhelmed by coursework'.
VALUE LABELS stress1
  1 'Strongly disagree'
  2 'Disagree'
  3 'Neutral'
  4 'Agree'
  5 'Strongly agree'.

*stress2.
VARIABLE LEVEL  stress2(ORDINAL).
VARIABLE LABELS  stress2 'I worry about exams'.
VALUE LABELS stress2
  1 'Strongly disagree'
  2 'Disagree'
  3 'Neutral'
  4 'Agree'
  5 'Strongly agree'.

*stress3.
VARIABLE LEVEL  stress3(ORDINAL).
VARIABLE LABELS  stress3 'I find it hard to relax'.
VALUE LABELS stress3
  1 'Strongly disagree'
  2 'Disagree'
  3 'Neutral'
  4 'Agree'
  5 'Strongly agree'.

*stress4.
VARIABLE LEVEL  stress4(ORDINAL).
VARIABLE LABELS  stress4 'I feel tense about deadlines'.
VALUE LABELS stress4
  1 'Strongly disagree'
  2 'Disagree'
  3 'Neutral'
  4 'Agree'
  5 'Strongly agree'.

*stress5_calm.
VARIABLE LEVEL  stress5_calm(ORDINAL).
VARIABLE LABELS  stress5_calm 'I feel calm and in control (REVERSE-WORDED)'.
VALUE LABELS stress5_calm
  1 'Strongly disagree'
  2 'Disagree'
  3 'Neutral'
  4 'Agree'
  5 'Strongly agree'.

*gpa.
VARIABLE LABELS  gpa 'Grade point average (0.00 - 4.00)'.
EXECUTE.

* Task-4 [Recoding gender column and checking consistency]:

DATASET ACTIVATE DataSet1.
RECODE gender ('1'='Male') ('Male'='Male') ('male'='Male') ('M'='Male') ('2'='Female') 
    ('Female'='Female') ('female'='Female') ('F'='Female').
EXECUTE.

DATASET ACTIVATE DataSet1.
RECODE gender ('Male'='1') ('Female'='2').
EXECUTE.
VARIABLE LEVEL  gender(SCALE).
VARIABLE LABELS  gender 'Gender of respondent'.
VALUE LABELS gender
  '1     ' 'Male'
  '2     ' 'Female'.
EXECUTE.

FREQUENCIES VARIABLES=gender
  /STATISTICS=RANGE MINIMUM MAXIMUM STDDEV MEAN MEDIAN
  /FORMAT=NOTABLE
  /ORDER=ANALYSIS.

FREQUENCIES VARIABLES=year_of_study
  /STATISTICS=RANGE MINIMUM MAXIMUM STDDEV MEAN MEDIAN
  /FORMAT=NOTABLE
  /ORDER=ANALYSIS.

FREQUENCIES VARIABLES=study_hours_week
  /STATISTICS=RANGE MINIMUM MAXIMUM STDDEV MEAN MEDIAN
  /FORMAT=NOTABLE
  /ORDER=ANALYSIS.

FREQUENCIES VARIABLES=sleep_hours
  /STATISTICS=RANGE MINIMUM MAXIMUM STDDEV MEAN MEDIAN
  /FORMAT=NOTABLE
  /ORDER=ANALYSIS.

FREQUENCIES VARIABLES=attendance_pct
  /STATISTICS=RANGE MINIMUM MAXIMUM STDDEV MEAN MEDIAN
  /FORMAT=NOTABLE
  /ORDER=ANALYSIS.

FREQUENCIES VARIABLES=gpa
  /STATISTICS=RANGE MINIMUM MAXIMUM STDDEV MEAN MEDIAN
  /FORMAT=NOTABLE
  /ORDER=ANALYSIS.

* Task-5 [Fixing missing values]:

MISSING VALUES sleep_hours (99)
EXECUTE.
MISSING VALUES attendance_pct (250)
EXECUTE.

* Task-6 [Finding and removing duplicate observations]:

* Identify Duplicate Cases.
SORT CASES BY student_id(A).
MATCH FILES
  /FILE=*
  /BY student_id
  /FIRST=PrimaryFirst
  /LAST=PrimaryLast_sorted_by_student_id.
DO IF (PrimaryFirst).
COMPUTE  MatchSequence=1-PrimaryLast_sorted_by_student_id.
ELSE.
COMPUTE  MatchSequence=MatchSequence+1.
END IF.
LEAVE  MatchSequence.
FORMATS  MatchSequence (f7).
COMPUTE  InDupGrp=MatchSequence>0.
SORT CASES InDupGrp(D).
MATCH FILES
  /FILE=*
  /DROP=PrimaryFirst InDupGrp MatchSequence.
VARIABLE LABELS  PrimaryLast_sorted_by_student_id 'Indicator of each last matching case as Primary'.    
VALUE LABELS  PrimaryLast_sorted_by_student_id 0 'Duplicate Case' 1 'Primary Case'.
VARIABLE LEVEL  PrimaryLast_sorted_by_student_id (ORDINAL).
FREQUENCIES VARIABLES=PrimaryLast_sorted_by_student_id.
EXECUTE.

* Removing duplicates permanently:

SELECT IF (PrimaryLast_sorted_by_student_id = 1).
EXECUTE.

*There were 2 duplicate cases out of 302 cases, 300 primary cases remain after deduplication.

* Task-7 [Reverse coding and adding stress_total variable]:

COMPUTE stress5_r=6-stress5_calm.
EXECUTE.

COMPUTE stress_total=stress1 + stress2 + stress3 + stress4 + stress5_r.
EXECUTE.

* Task-8 [Checking summary and drawing histogram]:

FREQUENCIES VARIABLES=study_hours_week sleep_hours attendance_pct
  /FORMAT=NOTABLE
  /STATISTICS=RANGE MINIMUM MAXIMUM MEAN MEDIAN
  /HISTOGRAM
  /ORDER=ANALYSIS.

* Task-9 [Checking frequency table and drawing bar chart]:

FREQUENCIES VARIABLES=faculty year_of_study
  /BARCHART FREQ
  /ORDER=ANALYSIS.

DATASET ACTIVATE DataSet1. 
 
SAVE OUTFILE='E:\Statistical '+ 
    'Softwares\SPSS\CUSPC-SPSS\Assignments\Assignment-1\assignment1_Shah_Md._Tasrif_Rahman\assignme'+ 
    'nt1_data_Shah_Md._Tasrif_Rahman.sav' 
  /COMPRESSED.

* Task-10 [Exporting output]:

OUTPUT SAVE NAME=Document1
 OUTFILE='E:\Statistical '+
    'Softwares\SPSS\CUSPC-SPSS\Assignments\Assignment-1\assignment1_Shah_Md._Tasrif_Rahman\assignme'+
    'nt1_Shah_Md._Tasrif_Rahman_Output.spv'
 LOCK=NO.

* Export Output.
OUTPUT EXPORT
  /CONTENTS  EXPORT=VISIBLE  LAYERS=PRINTSETTING  MODELVIEWS=PRINTSETTING
  /DOC  DOCUMENTFILE='E:\Statistical '+
    'Softwares\SPSS\CUSPC-SPSS\Assignments\Assignment-1\assignment1_Shah_Md._Tasrif_Rahman\assignme'+
    'nt1_data_Shah_Md._Tasrif_Rahman.doc'
     NOTESCAPTIONS=YES  WIDETABLES=SHRINK PAGEBREAKS=YES
     PAGESIZE=INCHES(8.267000000000001, 11.69)  TOPMARGIN=INCHES(1.0)  BOTTOMMARGIN=INCHES(1.0)
     LEFTMARGIN=INCHES(1.0)  RIGHTMARGIN=INCHES(1.0000000000000018).
