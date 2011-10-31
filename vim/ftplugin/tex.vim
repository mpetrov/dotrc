
setlocal makeprg=pdflatex\ -file-line-error\ -interaction\ nonstopmode\ % 


function! s:QfPDFOpen() 
   let qflist = getqflist() 
   let openpdfname = "!open " . expand("%:t:r") . ".pdf" 
   let dontopen = 0 
   for i in qflist 
       if i.valid != 0 
           let dontopen = 1 
       endif 
   endfor 
   if dontopen == 0 
       silent execute openpdfname 
   endif 
   execute ":cwindow" 
endfunction 

au QuickfixCmdPost make call s:QfPDFOpen() 

