.global main

main:
	li		s3,1
	li		s2,100
	li		s1,0
	bgt		s3,s2,end

loop:
	add		s1,s1,s3
	addi		s3,s3,1
	ble		s3,s2,loop

end:
	j 		end

