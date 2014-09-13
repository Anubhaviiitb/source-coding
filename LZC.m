%The code is composed of three functions 
%First is the main function which takes the input string as a argument.

%Second function is LZC_Encoding.
%It takes the input string as a argument and returns the encoded string

%Third function is LZC_Decoding
%It takes encoded string as a argument and writes the output to the file output_LCZ.txt

%Sample input
%LCZ("This is LCZ encoing decoding")



function LZC()
   mid = fileread('input.txt');
   input_string = mid;
   store = isalpha(input_string);
   
   for i = 1:1:length(store)
    if(store(i) == 0)
      input_string(i) = ' ';
    endif
   endfor
   
   input_string = tolower(input_string);
   
   [dict, output] = LZC_Encoding(input_string);
   LZC_Decoding(output);
   
endfunction

function[dict, output] =  LZC_Encoding(input_string)  
   output = [];
  dictionary = [];
  ascii = [97:1:122]';
  dict = char(ascii);
  for i = 1:1:26
    dictionary{i} = dict(i);
  endfor 
  
  dictionary{27} = ' ';
  
  STRING = input_string(1);
  length_dict = length(dictionary);
  count = 0;
  for i = 2:1:length(input_string)
  
      count++;
      SYMBOL = input_string(i);
      temp = [STRING  SYMBOL];
      if(find(strcmp(temp, dictionary)) > 0)
        STRING = [STRING  SYMBOL];
      else
        output = [output; find(strcmp(STRING, dictionary)) - 1];
        dictionary{1,length_dict+1} = [STRING SYMBOL];
        length_dict = length_dict + 1;
        STRING = SYMBOL;
      endif
   endfor
   count
 dictionary
 output = [output; find(strcmp(STRING, dictionary)) - 1]
 
 endfunction

function[result] = LZC_Decoding(output, dict)
  RESULT = [];
  TABLE = [];
  ascii = [97:1:122]';
  endic = char(ascii);
  
  for i = 1:1:26
    TABLE{i} = endic(i);
  endfor
  
  TABLE{27} = ' ';
  
  CODE = output(1);
  STRING_DE = TABLE{CODE+1};
  STRING_DE;
  RESULT = [RESULT, STRING_DE];
  len_table = length(TABLE);
  
  
  for j = 2:1:length(output)
    CODE = output(j);
    if(CODE >= length(TABLE))
      ENTRY = [STRING_DE  STRING_DE(1)];
    else  
      ENTRY = TABLE{CODE+1};
    endif
    ENTRY;
    RESULT = [RESULT, ENTRY];
    TABLE{1,len_table + 1} = [STRING_DE  ENTRY(1)];
    len_table = len_table + 1;
    STRING_DE = ENTRY;
   endfor
  gid = fopen("output_LCZ.txt",'w');
  fputs(gid, RESULT);
  
endfunction
