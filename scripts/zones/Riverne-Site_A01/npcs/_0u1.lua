-----------------------------------
-- Area: Riverne Site #A01
--  NPC: Unstable Displacement
-----------------------------------
local riverneAGlobal = require("scripts/zones/Riverne-Site_A01/globals")
require("scripts/globals/teleports")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    riverneAGlobal.unstableDisplacementTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    riverneAGlobal.unstableDisplacementTrigger(player, npc, 6)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 6 then
        xi.teleport.clearEnmityList(player)
    end
end

return entity
