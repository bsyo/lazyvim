return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local in_tmux = os.getenv("TMUX") ~= nil

      if in_tmux then
        -- lualine_b: 替换为搜索和选择计数
        opts.sections.lualine_b = {
          {
            "searchcount", -- 显示搜索匹配数量
            maxcount = 999,
            timeout = 500,
          },
          {
            "selectioncount", -- 显示选中的字符/行数
          },
        }

        -- lualine_z:
        opts.sections.lualine_z = {}

        -- 修改右侧信息，移除 git diff 和 lazy 更新信息
        local x_components = {}
        for _, component in ipairs(opts.sections.lualine_x) do
          if
            type(component) == "table"
            and component[1] ~= "diff"
            and not (type(component.cond) == "function" and component.cond == require("lazy.status").has_updates)
          then
            table.insert(x_components, component)
          elseif type(component) == "function" or (type(component) == "string" and component ~= "diff") then
            table.insert(x_components, component)
          end
        end
        opts.sections.lualine_x = x_components
      end

      return opts
    end,
  },
}
