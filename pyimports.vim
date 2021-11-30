augroup PyImport
	autocmd!
    autocmd FileType python iabbrev <buffer> iscipy import scipy
    autocmd FileType python iabbrev <buffer> inumpy import numpy as np
    autocmd FileType python iabbrev <buffer> imatplotlib import matplotlib.pyplot as plt
    autocmd FileType python iabbrev <buffer> ipickle import pickle
    autocmd FileType python iabbrev <buffer> ijson import json
	autocmd FileType python iabbrev <buffer> ios import os
	autocmd FileType python iabbrev <buffer> iosp from os import path
augroup end
"}}}

