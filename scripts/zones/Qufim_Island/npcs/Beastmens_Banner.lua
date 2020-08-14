-----------------------------------
-- Area: Qufim_Island
--  NPC: Beastmen_s_Banner
-- !pos 0.348 -20.126 73.479 126
-----------------------------------
local ID = require("scripts/zones/Qufim_Island/IDs")
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
