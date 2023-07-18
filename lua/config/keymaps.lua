-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap



keymap("n", "<F6>", ":<esc>:source $MYVIMRC<CR>",opts)
if vim.loop.os_uname().sysname == 'Linux' then
    keymap("n", "rc",":w<CR> :e $HOME/.config/nvim/lua<CR>" ,opts)
    keymap("n", "note", ":w<CR> :e $HOME/.note.txt<CR>",opts)
    keymap("n", "test", ":w<CR> :e $HOME/.test.py<CR>",opts)
elseif vim.loop.os_uname().sysname == 'Windows_NT' then
    keymap("n", "rc",":w<CR> :e $HOME\\AppData\\Local\\nvim\\lua<CR>" ,opts)
    keymap("n", "note", ":w<CR> :e $HOME\\.note.txt<CR>",opts)
    keymap("n", "test", ":w<CR> :e $HOME\\.test.py<CR>",opts)
end
keymap("n", "<TAB>", ">>", opts)
keymap("n", "<S-TAB>", "<<", opts)
keymap("v", "<TAB>", ">gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "<S-TAB>", "<gv", opts)
keymap("v", "<", "<gv", opts)

keymap("n", "<C-s>", "<esc>:w!<CR>", opts)
keymap("n", "<C-z>",  "<C-o>", opts)
keymap("i", "<C-s>", "<esc>:w!<CR>", opts)
keymap("i", "<C-z>",  "<esc><C-o>", opts)
keymap("i", "<C-v>", "<esc>pa", opts)


keymap("n", "term",":terminal<CR>i", opts)

keymap("n", "<F5>",":RunCode<CR>", opts)

keymap("n", "spl", ":set splitright<CR>:vsplit<CR> ", opts)
keymap("n", "spk", ":set splitbelow<CR>:split<CR> ", opts)
keymap("n", "<A-Right>", ":vertical resize-5 <CR> ", opts)
keymap("n", "<A-Left>", ":vertical resize+5 <CR> ", opts)
keymap("n", "<A-Up>", ":resize-5 <CR> ", opts)
keymap("n", "<A-Down>", ":resize+5 <CR> ", opts)










keymap("t", "<ESC>", "<C-\\><C-n>", term_opts)

keymap("n", "ty", "<cmd>BufferLineCycleNext<CR>", opts)
keymap("n", "tr", "<cmd>BufferLineCyclePrev<CR>", opts)
keymap("n", "td", "<cmd>bd!<CR>", opts)
keymap("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", opts)
keymap("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", opts)
keymap("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", opts)
keymap("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", opts)
keymap("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", opts)
keymap("n", "<leader>6", "<cmd>BufferLineGoToBuffer 6<cr>", opts)
keymap("n", "<leader>7", "<cmd>BufferLineGoToBuffer 7<cr>", opts)
keymap("n", "<leader>8", "<cmd>BufferLineGoToBuffer 8<cr>", opts)
keymap("n", "<leader>9", "<cmd>BufferLineGoToBuffer 9<cr>", opts)
keymap("n", "<leader>$", "<cmd>BufferLineGoToBuffer -1<cr>", opts)


keymap("t", "ty", "<C-\\><C-n><cmd>BufferLineCycleNext<CR>", term_opts)
keymap("t", "tr", "<C-\\><C-n><cmd>BufferLineCyclePrev<CR>", term_opts)
keymap("t", "td", "<C-\\><C-n><cmd>bd!<CR>", term_opts)
keymap("t", "<leader>1", "<C-\\><C-n><cmd>BufferLineGoToBuffer 1<cr>", term_opts)
keymap("t", "<leader>2", "<C-\\><C-n><cmd>BufferLineGoToBuffer 2<cr>", term_opts)
keymap("t", "<leader>3", "<C-\\><C-n><cmd>BufferLineGoToBuffer 3<cr>", term_opts)
keymap("t", "<leader>4", "<C-\\><C-n><cmd>BufferLineGoToBuffer 4<cr>", term_opts)
keymap("t", "<leader>5", "<C-\\><C-n><cmd>BufferLineGoToBuffer 5<cr>", term_opts)
keymap("t", "<leader>6", "<C-\\><C-n><cmd>BufferLineGoToBuffer 6<cr>", term_opts)
keymap("t", "<leader>7", "<C-\\><C-n><cmd>BufferLineGoToBuffer 7<cr>", term_opts)
keymap("t", "<leader>8", "<C-\\><C-n><cmd>BufferLineGoToBuffer 8<cr>", term_opts)
keymap("t", "<leader>9", "<C-\\><C-n><cmd>BufferLineGoToBuffer 9<cr>", term_opts)
keymap("t", "<leader>$", "<C-\\><C-n><cmd>BufferLineGoToBuffer -1<cr>", term_opts)





