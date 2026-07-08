-----------------------------------
-- Area: The Eldieme Necropolis
-- NPC: Tallow Candle
-- !pos -655.27 -2.30 214.58
-----------------------------------
local necropolisGlobal = require('scripts/zones/The_Eldieme_Necropolis/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    necropolisGlobal.handleCandleTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    necropolisGlobal.handleCandleTrigger(player, npc)
end

return entity
