return {
  {
    "stephencelis/vim-mml",
    ft = { "mml" },
  },
  {
    "monaqa/dial.nvim",
    vscode = true,
    ft = { "mml" },
    config = function()
      --      vim.keymap.set("v", "<C-a>", function()
      --        require("dial.map").manipulate("increment", "visual")
      --      end)
      --      vim.keymap.set("v", "<C-x>", function()
      --        require("dial.map").manipulate("decrement", "visual")
      --      end)
      --      vim.keymap.set("v", "g<C-a>", function()
      --        require("dial.map").manipulate("increment", "gvisual")
      --      end)
      --      vim.keymap.set("v", "g<C-x>", function()
      --        require("dial.map").manipulate("decrement", "gvisual")
      --      end)

      local modify_note = function(text, addend, cursor)
        print("text", text)
        print("addend", addend)
        if cursor ~= nil then
          print("cursor", cursor)
        end
        local modifiers, note = string.match(text, '([`|"]*)([a-g])')
        if modifiers == nil then
          modifiers = ""
        end
        local notes = { "c", "d", "e", "f", "g", "a", "b" }
        local index = (string.find(table.concat(notes, ""), note) + addend - 1) % 7 + 1
        local new_note = notes[index]
        local octave_change = math.floor((string.find(table.concat(notes, ""), note) + addend - 1) / 7)
        if string.find(modifiers, "`") then
          octave_change = octave_change + #modifiers
        elseif string.find(modifiers, '"') then
          octave_change = octave_change - #modifiers
        end

        local new_modifiers = ""
        if octave_change > 0 then
          new_modifiers = string.rep("`", octave_change)
        elseif octave_change < 0 then
          new_modifiers = string.rep('"', -octave_change)
        end

        local new_text = new_modifiers .. new_note

        return {
          text = new_text,
          cursor = #new_text,
        }
      end

      local augend = require("dial.augend")

      local musical_notes = augend.user.new({
        find = require("dial.augend.common").find_pattern('`*"*[a-g]'),

        add = modify_note,
      })

      require("dial.config").augends:register_group({
        default = {
          musical_notes,
          augend.integer.alias.decimal,
          -- Add other default augends here
        },
        note = {
          musical_notes,
        },
      })

      --      local cursor = require("user-utils.cursor")
      --      local increment_whole_selection = function()
      --        local iter = cursor.create_iterator()
      --        local pos = iter()
      --        while pos do
      --          local line, col = unpack(pos)
      --          print("line", line)
      --          print("col", col)
      --          -- require("dial.map").inc_normal()
      --          pos = iter()
      --        end
      --      end
      --
      --      local function print_chars_in_selection()
      --        for line, col in cursor.iterate_visual_selection() do
      --          vim.api.nvim_win_set_cursor(0, { line, col + 1 })
      --          vim.cmd("redraw")
      --          require("dial.map").manipulate("increment", "normal", "note")
      --        end
      --      end

      vim.keymap.set("n", "<C-a>", function()
        require("dial.map").manipulate("increment", "normal")
      end)
      vim.keymap.set("n", "<C-x>", function()
        require("dial.map").manipulate("decrement", "normal")
      end)
      vim.keymap.set("n", "g<C-a>", function()
        require("dial.map").manipulate("increment", "gnormal")
      end)
      vim.keymap.set("n", "g<C-x>", function()
        require("dial.map").manipulate("decrement", "gnormal")
      end)
      --      vim.keymap.set("v", "<leader>a", function()
      --        increment_whole_selection()
      --      end)
      --      vim.keymap.set("v", "<leader>x", function()
      --        decrement_whole_selection()
      --      end)
      --      vim.keymap.set("v", "<C-a>", function()
      --        require("dial.map").manipulate("increment", "visual")
      --      end)
      --      vim.keymap.set("v", "<C-x>", function()
      --        require("dial.map").manipulate("decrement", "visual")
      --      end)
      --      vim.keymap.set("v", "g<C-a>", function()
      --        require("dial.map").manipulate("increment", "gvisual")
      --      end)
      --      vim.keymap.set("v", "g<C-x>", function()
      --        require("dial.map").manipulate("decrement", "gvisual")
      --      end)
    end,
  },
}
