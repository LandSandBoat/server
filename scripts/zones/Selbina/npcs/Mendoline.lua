-----------------------------------
-- Area: Selbina
--  NPC: Mendoline
-- Guild Merchant NPC: Fishing Guild
-- !pos -13.603 -7.287 10.916 248
-----------------------------------
local ID = require("scripts/zones/Selbina/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:sendGuild(5182, 3, 18, 5) then
        player:showText(npc, ID.text.FISHING_SHOP_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
