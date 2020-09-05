-----------------------------------
-- Area: Port Windurst
--  NPC: Babubu
-- Guild Merchant NPC: Fishing Guild
-- !pos -175.185 -3.324 70.445 240
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
local ID = require("scripts/zones/Port_Windurst/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:sendGuild(517, 3, 18, 5)) then
        player:showText(npc, ID.text.BABUBU_SHOP_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
