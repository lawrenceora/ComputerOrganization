module seven(HEX, SW);
	input[3:0] SW;
	output[6:0] HEX;

	assign HEX[0] =  ~SW[3] & ~SW[2] & ~SW[1] &  SW[0] | //1
			 ~SW[3] &  SW[2] & ~SW[1] & ~SW[0] | //4
			  SW[3] & ~SW[2] &  SW[1] &  SW[0] | //B
			  SW[3] &  SW[2] & ~SW[1] &  SW[0] ; //D

	assign HEX[1] =  ~SW[3] &  SW[2] & ~SW[1] &  SW[0] | //5
			  SW[3] &  SW[2] &          ~SW[0] | //C, E
			  SW[3] &           SW[1] &  SW[0] | //B, F
			           SW[2] &  SW[1] & ~SW[0] ; //6, E

	assign HEX[2] =  ~SW[3] & ~SW[2] &  SW[1] & ~SW[0] | //2
			  SW[3] &  SW[2] &          ~SW[0] | //C, E
			  SW[3] &  SW[2] &  SW[1]          ; //E, F

	assign HEX[3] =  ~SW[3] &  SW[2] & ~SW[1] & ~SW[0] | //4
			  SW[3] & ~SW[2] &  SW[1] & ~SW[0] | //A
			          ~SW[2] & ~SW[1] &  SW[0] | //1,9
			           SW[2] &  SW[1] &  SW[0] ; //7,F

	assign HEX[4] =           ~SW[2] & ~SW[1] &  SW[0] | //1,9
			 ~SW[3] &  SW[2] & ~SW[1]          | //4,5
			 ~SW[3] &                    SW[0] ; //1,3,5,7

	assign HEX[5] =   SW[3] &  SW[2] & ~SW[1] &  SW[0] | //D
			 ~SW[3] & ~SW[2]          &  SW[0] | //1,3
			 ~SW[3] & ~SW[2] &  SW[1]          | //2,3
			 ~SW[3] &           SW[1] &  SW[0] ; //3,7

	assign HEX[6] =  ~SW[3] &  SW[2] &  SW[1] &  SW[0] | //7
			  SW[3] &  SW[2] & ~SW[1] & ~SW[0] | //C
			 ~SW[3] & ~SW[2]  & ~SW[1]         ; //1,0
endmodule