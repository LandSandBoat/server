-----------------------------------
-- Area: Riverne Site #A01
--  NPC: Unstable Displacement
-----------------------------------
local RIVERNE_SITE_A01 = require("scripts/zones/Riverne-Site_A01/globals")
-----------------------------------

function onTrade(player, npc, trade)
    RIVERNE_SITE_A01.unstableDisplacementTrade(player, npc, trade)
end

function onTrigger(player, npc)
    RIVERNE_SITE_A01.unstableDisplacementTrigger(player, npc, 32)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
