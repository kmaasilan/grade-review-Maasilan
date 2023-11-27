CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

var=0

if ! [[ -f ./student-submission/ListExamples.java ]]
then
	echo 'ListExamples.java NOT found'
else
	echo 'ListExamples.java found'
	((var+=1))
fi

numListExamples=`grep -c 'ListExamples' ./student-submission/ListExamples.java`

if [[ $numListExamples -eq 0 ]]
then
	echo 'ListExamples NOT found'
else
	echo 'ListExamples found'
	((var+=1))
fi

numFilter=`grep -c 'filter' ./student-submission/ListExamples.java`

if [[ $numFilter -eq 0 ]]
then
	echo 'filter NOT found'
else
	echo 'filter found'
	((var+=1))
fi

numMerge=`grep -c 'merge' ./student-submission/ListExamples.java`

if [[ $numMerge -eq 0 ]]
then
	echo 'merge NOT found'
else
	echo 'merge found'
	((var+=1))
fi

cp TestListExamples.java ./student-submission/ListExamples.java ./grading-area
cp -r lib ./grading-area

cd grading-area

javac -cp $CPATH *.java
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > JUnit_output.txt

if [[ `grep -c 'FAILURES!!!' JUnit_output.txt` -eq 0 ]]
then 
	echo 'failures NOT found'
	((var+=1))
else 
	echo 'failures found'
fi

cat JUnit_output.txt

echo $var out of 5 tests passed

#Assume the assignment spec was to submit:
#-A repository with a file called ListExamples.java
#-In that file, a class called ListExamples
#-In that class two methods:
# -static List<String> filter(List<String> s, StringChecker sc)
# -static List<String> merge(List<String> list1, List<String> list2)
#-These methods should have the implementations suggested in lab 3

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
