-----------------------------------
-- Area: Buburimu_Peninsula
--  NPC: Beastmen_s_Banner
-- !pos -132.589 19.999 -314.261 118
-----------------------------------
local ID = require("scripts/zones/Buburimu_Peninsula/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.BEASTMEN_BANNER)
end

function onEventUpdate(player, csid, option)
    -- printf("OPTION: %u", option)
end

function onEventFinish(player, csid, option)
    -- printf("OPTION: %u", option)
end
