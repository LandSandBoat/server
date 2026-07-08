-----------------------------------
-- Area: Riverne Site #B01
--  NPC: Unstable Displacement
-----------------------------------
local riverneBGlobal = require('scripts/zones/Riverne-Site_B01/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    riverneBGlobal.unstableDisplacementTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    riverneBGlobal.unstableDisplacementTrigger(player, npc, 22)
end

return entity
