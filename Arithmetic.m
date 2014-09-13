%The code is composed of  three functions: LZC(it is the main function of this file and takes the arguments: (input sring, character matrix, probablity array))
%character matrix is 1xN matrix of characters for which the probablity is given
%Probablity array is the array of probablities corrosponding to each element in the character matrix

%second function is Arithmetic_encode()
%it takes the input_string, character matrix and probablity array as the arguments and returns encoded string, low_range and high_range.
%low_range is the array containing low ranges corrosponding to each character generated by their corrosponding probablities. Similarly high_range

%third function is Arithmetic_decode()
%it takes the encoded string, low_range, high_range and character matrix as input and returns the result.


%sample input
%ocatve
%load Arithmetic.m
%Arithmetic("BILL GATES BAEGI LIES")
%output will be stored in the same folder with file name output_aram.txt


function Arithmetic(input_string)
  char_array = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'}
  prob_array = [0.08167, 0.01492, 0.02782, 0.04253, 0.12702, 0.02228, 0.02015, 0.06094, 0.06966, 0.00153, 0.00772, 0.04025, 0.02406, 0.06749, 0.07507, 0.01929, 0.00095,0.05987, 0.06327, 0.09056, 0.02758, 0.00978, 0.02360, 0.00150, 0.01974, 0.00075]
  [encode, low_range, high_range] = Arithmetic_encode(input_string, char_array, prob_array);
  Arithmetic_decode(encode, low_range, high_range, char_array)
endfunction


function[encode, low_range, high_range] = Arithmetic_encode(input_string, char_array, prob_array)
  encode = [];
  prob_array;
  low_range = [];
  high_range = [];
  start = 0;
  for i = 1:1:length(prob_array)
    low_range = [low_range, start];
    high_range = [high_range, start+prob_array(i)];
    start = start+prob_array(i);
  endfor

  input_string = strsplit(input_string,' ');
  
  for i = 1:1:length(input_string);
      input_symbol = input_string{i};
      low = 0.0;
      high = 1.0;
      for j = 1:1:length(input_symbol)
        input_char = input_symbol(j);
        index = find(strcmp(input_char, char_array));
        range = high-low;
        high = low + range * high_range(index);
        low = low + range * low_range(index);
      
        
    endfor
    encode = [encode, low];
  endfor
  encode
endfunction


function Arithmetic_decode(encode, low_range, high_range, char_array)
  word = [];
  for i = 1:length(encode)
    current = encode(i);
    while(current > 1e-5)
      for k = 1:length(char_array)
        high = high_range(k);
        low = low_range(k);
        
        if((current < high) && (current >= low))
          word = [word, char_array{k}]
          range_de = high_range(k) - low_range(k)-1e-15;
          current = current - low_range(k);
          current = current / range_de;
          if(current < 1e-5)
            break;
          endif
         endif
         
       endfor
        
     endwhile
     word = [word, ' '];
   endfor
   
   gid = fopen("output_aram.txt",'w');
  fputs(gid, word);
endfunction
