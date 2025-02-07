return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- 检查是否在 tmux 中
      local in_tmux = os.getenv("TMUX") ~= nil

      if in_tmux then
        -- 在 tmux 中时的修改
        opts.sections.lualine_b = {} -- 移除 git branch 信息
        opts.sections.lualine_z = {} -- 移除时间显示

        -- 修改右侧信息，移除 git diff 信息
        local x_components = {}
        for _, component in ipairs(opts.sections.lualine_x) do
          -- 保留非 diff 的组件
          if type(component) == "table" and component[1] ~= "diff" then
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
