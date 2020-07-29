-----------------------------------
-- Area: Beaucedine_Glacier
--  NPC: Beastmen_s_Banner
-- !pos 20.169 -80.078 180.063 111
-----------------------------------
local ID = require("scripts/zones/Beaucedine_Glacier/IDs")
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
