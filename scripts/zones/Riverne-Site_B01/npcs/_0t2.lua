-----------------------------------
-- Area: Riverne Site #B01
--  NPC: Unstable Displacement
-----------------------------------
local riverneBGlobal = require("scripts/zones/Riverne-Site_B01/globals")
require("scripts/globals/teleports")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    riverneBGlobal.unstableDisplacementTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    riverneBGlobal.unstableDisplacementTrigger(player, npc, 22)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 22 then
        xi.teleport.clearEnmityList(player)
    end
end

return entity
