local gpu_adapters = require('utils.gpu-adapter')
local colors = require('colors.custom')
local config = {}

config.max_fps = 120
config.front_end = 'WebGpu'
config.webgpu_power_preference = 'HighPerformance'
config.webgpu_preferred_adapter = gpu_adapters:pick_best()
   -- webgpu_preferred_adapter = gpu_adapters:pick_manual('Dx12', 'IntegratedGpu'),
   -- webgpu_preferred_adapter = gpu_adapters:pick_manual('Gl', 'Other'),
config.underline_thickness = '1.5pt'

   -- cursor
config.animation_fps = 120
config.cursor_blink_ease_in = 'EaseOut'
config.cursor_blink_ease_out = 'EaseOut'
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 650

   -- color scheme
config.colors = colors


   -- scrollbar
config.enable_scroll_bar = true

   -- tab bar
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_max_width = 25
config.show_tab_index_in_tab_bar = false
config.switch_to_last_active_tab_when_closing_tab = true

   -- window
config.window_padding = {
      left = 0,
      right = 0,
      top = 10,
      bottom = 7.5,
   }
config.adjust_window_size_when_changing_font_size = false
config.window_close_confirmation = 'NeverPrompt'
config.window_frame = {
      active_titlebar_bg = '#090909',
      -- font = fonts.font,
      -- font_size = fonts.font_size,
   }
   -- inactive_pane_hsb = {
   --    saturation = 0.9,
   --    brightness = 0.65,
   -- },
config.inactive_pane_hsb = {
      saturation = 1,
      brightness = 1,
   }

config.visual_bell = {
      fade_in_function = 'EaseIn',
      fade_in_duration_ms = 250,
      fade_out_function = 'EaseOut',
      fade_out_duration_ms = 250,
      target = 'CursorColor',
   }

return config