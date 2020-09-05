-----------------------------------
-- Area: Lower Jeuno
--  NPC: Akamafula
-- Type: Tenshodo Merchant
-- !pos 28.465 2.899 -46.699 245
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Lower_Jeuno/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:hasKeyItem(tpz.ki.TENSHODO_MEMBERS_CARD)) then
        if (player:sendGuild(60417, 1, 23, 1)) then
            player:showText(npc, ID.text.AKAMAFULA_SHOP_DIALOG)
        end
    else
        -- player:startEvent(150)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
