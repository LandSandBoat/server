-----------------------------------
-- Area: Riverne Site #B01
--  NPC: Unstable Displacement
-----------------------------------
local RIVERNE_SITE_B01 = require("scripts/zones/Riverne-Site_B01/globals")
-----------------------------------

function onTrade(player, npc, trade)
    RIVERNE_SITE_B01.unstableDisplacementTrade(player, npc, trade)
end

function onTrigger(player, npc)
    RIVERNE_SITE_B01.unstableDisplacementTrigger(player, npc, 22)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
