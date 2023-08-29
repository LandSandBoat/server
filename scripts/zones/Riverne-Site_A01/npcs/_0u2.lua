-----------------------------------
-- Area: Riverne Site #A01
--  NPC: Unstable Displacement
-----------------------------------
local riverneAGlobal = require('scripts/zones/Riverne-Site_A01/globals')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    riverneAGlobal.unstableDisplacementTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    riverneAGlobal.unstableDisplacementTrigger(player, npc, 17)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
