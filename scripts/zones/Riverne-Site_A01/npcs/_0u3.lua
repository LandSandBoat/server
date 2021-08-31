-----------------------------------
-- Area: Riverne Site #A01
--  NPC: Unstable Displacement
-----------------------------------
local RIVERNE_SITE_A01 = require("scripts/zones/Riverne-Site_A01/globals")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    RIVERNE_SITE_A01.unstableDisplacementTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    RIVERNE_SITE_A01.unstableDisplacementTrigger(player, npc, 19)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
