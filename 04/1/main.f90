PROGRAM DAY04
  IMPLICIT NONE

  ! This is the first program I have ever written in FORTRAN :) 
    
  INTEGER :: file_unit
  INTEGER :: ierr
  INTEGER, DIMENSION(1000,4) :: elves
  INTEGER :: row, col, max_rows
  INTEGER :: n_overlaps
  LOGICAL :: is_overlaping

  PRINT *, "OPENING FILE"
  file_unit = 10
  OPEN(unit=file_unit, file="input.dat", status='old', action='read', iostat=ierr)

  IF (ierr /= 0) THEN
    WRITE(*,*) "Error opening file"
    STOP
  endif 

  PRINT *, "READING DATA..."
  DO row=1, 1000
    READ(file_unit, *) elves(row,1), elves(row,2), elves(row,3), elves(row,4)
  ENDDO

  PRINT *, "CLOSING FILE"
  CLOSE(unit=file_unit)

  PRINT *, "CALCULATING..."
  DO row = 1,1000
    is_overlaping =  overlaps(elves(row,1),elves(row,2),elves(row,3),elves(row,4))
    IF (is_overlaping) THEN
      n_overlaps = n_overlaps + 1
    ENDIF
  END DO

  PRINT *, "ELVES THAT FULLY CONTAIN ANOTHER ", n_overlaps


  CONTAINS


  FUNCTION overlaps(a,b,c,d) RESULT (is_overlaping)
    IMPLICIT NONE
  
    INTEGER, INTENT(IN) :: a,b,c,d
    LOGICAL :: is_overlaping
  
    IF (a .LE. c .AND.  b .GE. d) THEN
      is_overlaping = .TRUE.
    ELSE IF (c .LE. a .AND.  d .GE. b) THEN  
      is_overlaping = .TRUE.
    ELSE 
      is_overlaping = .FALSE.
    ENDIF
  
  END FUNCTION overlaps

END PROGRAM DAY04
