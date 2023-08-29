-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: Tallow Candle
-- !pos -346.54 -2.30 336.66
-----------------------------------
local ID = require("scripts/zones/The_Eldieme_Necropolis/IDs")
local func = require("scripts/zones/The_Eldieme_Necropolis/globals")
require('scripts/globals/npc_util')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    func.candleOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    func.candleOnTrigger(player, npc)
end

return entity
