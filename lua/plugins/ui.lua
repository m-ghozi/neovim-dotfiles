return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[
         _________/\     __               
        /   _____/  |__ |__|______  ____  
        \_____  \|  |  \|  |_  __ \/ __ \ 
        /        \      \  ||  | \/  \_\ )
       /_______  /___|  /__||__|   \____/ 
               \/     \/                  
      ]]
      opts.config.header = vim.split(logo, "\n")
    end,
  },
}
