let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/WWU/W22/CPTR380/Project/CPTR380_Hess
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
$argadd instruction_set.vhd
set stal=2
tabnew
tabnew
tabnew
tabnew
tabrewind
edit instruction_set.vhd
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 130 + 130) / 261)
exe 'vert 2resize ' . ((&columns * 130 + 130) / 261)
argglobal
balt ioram.vhd
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 434 - ((49 * winheight(0) + 32) / 65)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 434
normal! 021|
wincmd w
argglobal
if bufexists("register_file.vhd") | buffer register_file.vhd | else | edit register_file.vhd | endif
if &buftype ==# 'terminal'
  silent file register_file.vhd
endif
balt instruction_set.syr
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 66 - ((54 * winheight(0) + 32) / 65)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 66
normal! 013|
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 130 + 130) / 261)
exe 'vert 2resize ' . ((&columns * 130 + 130) / 261)
tabnext
edit bram.vhd
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 130 + 130) / 261)
exe 'vert 2resize ' . ((&columns * 130 + 130) / 261)
argglobal
balt instruction_set.vhd
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 59 - ((57 * winheight(0) + 32) / 65)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 59
normal! 013|
wincmd w
argglobal
if bufexists("rom_memory.vhd") | buffer rom_memory.vhd | else | edit rom_memory.vhd | endif
if &buftype ==# 'terminal'
  silent file rom_memory.vhd
endif
balt instruction_set.vhd
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 56 - ((32 * winheight(0) + 32) / 65)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 56
normal! 033|
wincmd w
exe 'vert 1resize ' . ((&columns * 130 + 130) / 261)
exe 'vert 2resize ' . ((&columns * 130 + 130) / 261)
tabnext
edit alu_16bit.vhd
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 130 + 130) / 261)
exe 'vert 2resize ' . ((&columns * 130 + 130) / 261)
argglobal
balt instruction_set.vhd
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 57 - ((36 * winheight(0) + 32) / 65)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 57
normal! 037|
wincmd w
argglobal
if bufexists("ioram.vhd") | buffer ioram.vhd | else | edit ioram.vhd | endif
if &buftype ==# 'terminal'
  silent file ioram.vhd
endif
balt alu_16bit.vhd
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 49 - ((37 * winheight(0) + 32) / 65)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 49
normal! 036|
wincmd w
exe 'vert 1resize ' . ((&columns * 130 + 130) / 261)
exe 'vert 2resize ' . ((&columns * 130 + 130) / 261)
tabnext
edit control_logic.vhd
argglobal
balt alu_16bit.vhd
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 77 - ((29 * winheight(0) + 32) / 65)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 77
normal! 0
tabnext
edit register_file.vhd
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 130 + 130) / 261)
exe 'vert 2resize ' . ((&columns * 130 + 130) / 261)
argglobal
balt alu_16bit.vhd
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 43 - ((16 * winheight(0) + 32) / 65)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 43
normal! 025|
wincmd w
argglobal
if bufexists("bram.vhd") | buffer bram.vhd | else | edit bram.vhd | endif
if &buftype ==# 'terminal'
  silent file bram.vhd
endif
balt register_file.vhd
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 47 - ((45 * winheight(0) + 32) / 65)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 47
normal! 030|
wincmd w
exe 'vert 1resize ' . ((&columns * 130 + 130) / 261)
exe 'vert 2resize ' . ((&columns * 130 + 130) / 261)
tabnext 1
set stal=1
badd +438 instruction_set.vhd
badd +1 bram.vhd
badd +62 alu_16bit.vhd
badd +1 control_logic.vhd
badd +65 register_file.vhd
badd +182 wwu_fpga3_s6sdram_vector.ucf
badd +46 rom_memory.vhd
badd +71 ioram.vhd
badd +665 instruction_set.syr
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOF
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
