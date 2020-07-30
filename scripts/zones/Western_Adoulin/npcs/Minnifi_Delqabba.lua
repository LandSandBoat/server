-----------------------------------
-- Area: Western Adoulin
--  NPC: Minnifi Delqabba
-- Type: Shop NPC
-- !pos 77 4 -125 256
-----------------------------------
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- Standard dialogue
    player:showText(npc, ID.text.MINNIFI_DIALOGUE)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
