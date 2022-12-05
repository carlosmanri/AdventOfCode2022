PROGRAM DAY04
  IMPLICIT NONE
    
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
    is_overlaping =  in_range(elves(row,1), elves(row,3), elves(row,4)) .OR. in_range(elves(row,3), elves(row,1), elves(row,2))
    IF (is_overlaping) THEN
      n_overlaps = n_overlaps + 1
    ENDIF
  END DO

  PRINT *, "ELVES THAT OVERLAPS ", n_overlaps


  CONTAINS

  FUNCTION in_range(a,b,c) RESULT (is_in_range)
    IMPLICIT NONE
    INTEGER, INTENT(IN) :: a,b,c
    LOGICAL :: is_in_range

    IF (a >= b .AND. a <= c) THEN
      is_in_range = .TRUE.
    ELSE
      is_in_range = .FALSE.
    ENDIF
  END FUNCTION in_range


END PROGRAM DAY04
