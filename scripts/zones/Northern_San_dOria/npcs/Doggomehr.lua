-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Doggomehr
--  Guild Merchant NPC: Blacksmithing Guild
-- !pos -193.920 3.999 162.027 231
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:sendGuild(531, 8, 23, 2)) then
        player:showText(npc, ID.text.DOGGOMEHR_SHOP_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
