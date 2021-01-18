-----------------------------------
-- Area: Riverne Site #B01
--  NPC: Unstable Displacement
-----------------------------------
local RIVERNE_SITE_B01 = require("scripts/zones/Riverne-Site_B01/globals")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    RIVERNE_SITE_B01.unstableDisplacementTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    RIVERNE_SITE_B01.unstableDisplacementTrigger(player, npc, 7)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
