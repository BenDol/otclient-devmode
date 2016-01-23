--[[
  @Authors: Ben Dol
  @Details: Otclient module entry point. This handles
            main bot controls and functionality.
]]

local window
local content
local reloads

local reloadTriggers = {
  "all",
  "actions",
  "talkactions",
  "movements",
  "globalevents",
  "spells",
  "npc",
  "raids",
  "weapons",
  "monster"
}

function init()
  window = g_ui.displayUI('devmode.otui')
  window:breakAnchors()
  window:move(50, 80)
  window:hide()

  content = window:getChildById("content")
  reloads = content:getChildById("reloads")

  connect(g_game, {
    onGameStart = show,
    onGameEnd = hide
  })

  if g_game.isOnline() then
    show()
  end

  buildReloads()
end

function terminate()
  window:destroy()
  window = nil
end

function show()
  --if g_game.isGM() then
    window:show()
  --end
end

function hide()
  window:hide()
end

function buildReloads()
  for _,v in pairs(reloadTriggers) do
    local button = g_ui.createWidget("Button", reloads)
    button:setText(v)
    button.onClick = function()
      g_game.talk("/reload " .. v)
    end
  end
end