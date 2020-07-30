-----------------------------------
-- Area: Nashmau
--  NPC: Tsutsuroon
-- Type: Tenshodo Merchant
-- !pos -15.193 0.000 31.356 53
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Nashmau/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:hasKeyItem(tpz.ki.TENSHODO_MEMBERS_CARD)) then
        if (player:sendGuild(60431, 1, 23, 7)) then
            player:showText(npc, ID.text.TSUTSUROON_SHOP_DIALOG)
        end
    else
        -- player:startEvent(150)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
