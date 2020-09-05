-----------------------------------
-- Area: Manaclipper
--  NPC: Khots Chalahko
-- Type: NPC
-- !pos 0.019 -4.674 -18.782 3
-----------------------------------
local ID = require("scripts/zones/Manaclipper/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.KHOTS_CHALAHKO_OFFSET)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
