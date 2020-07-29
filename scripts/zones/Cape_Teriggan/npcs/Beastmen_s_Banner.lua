-----------------------------------
-- Area: Cape_Teriggan
--  NPC: Beastmen_s_Banner
-- !pos 162.059 -0.859 250.538 113
-----------------------------------
local ID = require("scripts/zones/Cape_Teriggan/IDs")
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
