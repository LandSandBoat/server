-----------------------------------
-- Area: Bastok Markets
--  NPC: Visala
--  Guild Merchant NPC: Goldsmithing Guild
-- !pos -202.000 -7.814 -56.823 235
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
local ID = require("scripts/zones/Bastok_Markets/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:sendGuild(5272, 8, 23, 4)) then
        player:showText(npc, ID.text.VISALA_SHOP_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
