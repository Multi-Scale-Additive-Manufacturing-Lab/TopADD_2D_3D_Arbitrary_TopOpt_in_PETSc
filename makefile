#PETSC_DIR=/cvmfs/soft.computecanada.ca/easybuild/software/2017/avx2/MPI/intel2016.4/openmpi2.1/petsc/3.9.0
#PETSC_DIR=/home/z496zhan/opt/petsc-3.10.2
PETSC_DIR=/home/z496zhan/opt/petsc-3.10.2_mumps_superlu_dist/
PETSC_ARCH=arch-linux-mpicc-debug
CFLAGS = -I.
FFLAGS=
CPPFLAGS=-I.
FPPFLAGS=
LOCDIR=
EXAMPLESC=
EXAMPLESF=
MANSEC=
CLEANFILES=
NP=


include ${PETSC_DIR}/lib/petsc/conf/variables
include ${PETSC_DIR}/lib/petsc/conf/rules
include ${PETSC_DIR}/lib/petsc/conf/test

CPPFLAGS+=-std=c++11 -Wall -O0 \
	-I./prepost \
	-I./prepost/vox \
	-I./timer \
	-I./compliant\
	-I./heat

ADD_SRC=${wildcard ./prepost/*.cc} \
	${wildcard ./prepost/vox/*.cc} \
	${wildcard ./timer/*.cc} \
	${wildcard ./compliant/*.cc} \
	${wildcard ./heat/*.cc}

ADD_OBJ=${patsubst %.cc,%.o,${ADD_SRC}}

topopt: main.o TopOpt.o LinearElasticity.o MMA.o Filter.o PDEFilter.o MPIIO.o ${ADD_OBJ} chkopts
	rm -rf topopt
	-${CLINKER} -o topopt main.o TopOpt.o LinearElasticity.o MMA.o Filter.o PDEFilter.o MPIIO.o ${ADD_OBJ} ${PETSC_SYS_LIB}
	${RM}  main.o TopOpt.o LinearElasticity.o MMA.o Filter.o PDEFilter.o MPIIO.o ${ADD_OBJ}
	rm -rf *.o ${ADD_OBJ}
			
myclean:
	rm -rf topopt *.o output* binary* log* makevtu.pyc Restart* ${ADD_OBJ}
	
