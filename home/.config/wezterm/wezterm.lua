local function read_file(filename)
    local file = io.open(filename, "r")
    if not file then
        return nil
    end
    local content = file:read("*a")
    file:close()
    return content
end

local function trim(s)
  return s and s:match("^%s*(.-)%s*$") or nil
end

-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = trim(read_file(os.getenv("HOME") .. "/.config/wezterm/color_scheme"))

config.font = wezterm.font(trim(read_file(os.getenv("HOME") .. "/.config/wezterm/font")))
config.font_size = tonumber(trim(read_file(os.getenv("HOME") .. "/.config/wezterm/font_size")))

config.leader = { key="s", mods="CTRL" }
config.keys = {
  { key = "a",  mods = "LEADER|CTRL",  action = wezterm.action.SendString("\x13") },
  { key = "-",  mods = "LEADER",       action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "|",  mods = "LEADER",       action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "\\", mods = "LEADER",       action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "s",  mods = "LEADER",       action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "v",  mods = "LEADER",       action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "o",  mods = "LEADER",       action = wezterm.action.TogglePaneZoomState },
  { key = "z",  mods = "LEADER",       action = wezterm.action.TogglePaneZoomState },
  { key = "c",  mods = "LEADER",       action = wezterm.action.SpawnTab("CurrentPaneDomain") },
  { key = "h",  mods = "LEADER",       action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "j",  mods = "LEADER",       action = wezterm.action.ActivatePaneDirection("Down") },
  { key = "k",  mods = "LEADER",       action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "l",  mods = "LEADER",       action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "H",  mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
  { key = "J",  mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
  { key = "K",  mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
  { key = "L",  mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
  { key = "1",  mods = "LEADER",       action = wezterm.action.ActivateTab(0) },
  { key = "2",  mods = "LEADER",       action = wezterm.action.ActivateTab(1) },
  { key = "3",  mods = "LEADER",       action = wezterm.action.ActivateTab(2) },
  { key = "4",  mods = "LEADER",       action = wezterm.action.ActivateTab(3) },
  { key = "5",  mods = "LEADER",       action = wezterm.action.ActivateTab(4) },
  { key = "6",  mods = "LEADER",       action = wezterm.action.ActivateTab(5) },
  { key = "7",  mods = "LEADER",       action = wezterm.action.ActivateTab(6) },
  { key = "8",  mods = "LEADER",       action = wezterm.action.ActivateTab(7) },
  { key = "9",  mods = "LEADER",       action = wezterm.action.ActivateTab(8) },
  { key = "&",  mods = "LEADER|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
  { key = "x",  mods = "LEADER",       action = wezterm.action.CloseCurrentPane({ confirm = true }) },
  { key = "p",  mods = "LEADER",       action = wezterm.action.ActivateTabRelative(-1) },
  { key = "n",  mods = "LEADER",       action = wezterm.action.ActivateTabRelative(1) },
  { key = "s",  mods = "LEADER|CTRL",  action = wezterm.action.ActivateLastTab },
  { key = "[",  mods = "LEADER",       action = wezterm.action.ActivateCopyMode },
  { key = " ",  mods = "CTRL",         action = wezterm.action.QuickSelect },
  { key = "?",  mods = "LEADER",       action = wezterm.action.ActivateCommandPalette },
  { key = "/",  mods = "CTRL",         action = wezterm.action.Search({ CaseInSensitiveString = "" }) },
}

config.key_tables = {
  search_mode = {
    -- Has to retain the default, otherwise will be wiped out.
    -- default {
    { key = "Enter",     mods = "NONE", action = wezterm.action.CopyMode("PriorMatch") },
    { key = "Escape",    mods = "NONE", action = wezterm.action.CopyMode("Close") },
    { key = "p",         mods = "CTRL", action = wezterm.action.CopyMode("PriorMatch") },
    { key = "n",         mods = "CTRL", action = wezterm.action.CopyMode("NextMatch") },
    { key = "r",         mods = "CTRL", action = wezterm.action.CopyMode("CycleMatchType") },
    { key = "u",         mods = "CTRL", action = wezterm.action.CopyMode("ClearPattern") },
    { key = "PageUp",    mods = "NONE", action = wezterm.action.CopyMode("PriorMatchPage") },
    { key = "PageDown",  mods = "NONE", action = wezterm.action.CopyMode("NextMatchPage") },
    { key = "UpArrow",   mods = "NONE", action = wezterm.action.CopyMode("PriorMatch") },
    { key = "DownArrow", mods = "NONE", action = wezterm.action.CopyMode("NextMatch") },
    -- } default
    { key = "[",   mods = "CTRL",  action = wezterm.action.CopyMode("Close") },
    { key = "c",   mods = "CTRL",  action = wezterm.action.CopyMode("Close") },
    { key = "Tab", mods = "NONE",  action = wezterm.action.CopyMode("PriorMatch") },
    { key = "Tab", mods = "SHIFT", action = wezterm.action.CopyMode("NextMatch") },
  },
}

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

-- and finally, return the configuration to wezterm
return config
