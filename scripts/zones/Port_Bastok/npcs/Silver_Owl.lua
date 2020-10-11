-----------------------------------
-- Area: Port Bastok
--  NPC: Silver Owl
-- Type: Tenshodo Merchant
-- !pos -99.155 4.649 23.292 236
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Port_Bastok/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:hasKeyItem(tpz.ki.TENSHODO_MEMBERS_CARD)) then
        if (player:sendGuild(60420, 1, 23, 4)) then
            player:showText(npc, ID.text.TENSHODO_SHOP_OPEN_DIALOG)
        end
    else
        player:startEvent(150, 1)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
