-----------------------------------
-- Area: Pashhow Marshlands
--  NPC: Beastmen_s_Banner
-- !pos -172.764 25.119 93.640 109
-----------------------------------
local ID = require("scripts/zones/Pashhow_Marshlands/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.BEASTMEN_BANNER)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
