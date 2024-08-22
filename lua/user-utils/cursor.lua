local M = {}

-- ビジュアル選択範囲の境界を取得する関数
local function get_visual_selection_bounds()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  return start_pos[2], start_pos[3], end_pos[2], end_pos[3]
end

-- 選択範囲内の次の位置を取得する関数
local function get_next_position(line, col, start_line, start_col, end_line, end_col)
  if line > end_line or (line == end_line and col >= end_col) then
    return nil, nil -- 選択範囲の終端に達した場合
  elseif col >= vim.fn.col({ line, "$" }) - 1 then
    return line + 1, start_col -- 行末に達した場合、次の行の開始へ
  else
    return line, col + 1 -- 通常は右に1文字進む
  end
end

-- イテレータ関数
function M.iterate_visual_selection()
  local start_line, start_col, end_line, end_col = get_visual_selection_bounds()
  local current_line, current_col = start_line, start_col

  return function()
    if current_line and current_col then
      local line, col = current_line, current_col
      current_line, current_col = get_next_position(line, col, start_line, start_col, end_line, end_col)
      return line, col
    end
  end
end

return M
