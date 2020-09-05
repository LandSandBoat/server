-----------------------------------
-- Area: Norg
--  NPC: Chiyo
-- Type: Tenshodo Merchant
-- !pos 5.801 0.020 -18.739 252
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Norg/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:hasKeyItem(tpz.ki.TENSHODO_MEMBERS_CARD)) then
        if (player:sendGuild(60422, 9, 23, 7)) then
            player:showText(npc, ID.text.CHIYO_SHOP_DIALOG)
        end
    else
        -- player:startEvent(150)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
