-----------------------------------
-- Area: Windurst Waters
--  NPC: Kopopo
-- Guild Merchant NPC: Cooking Guild
-- !pos -103.935 -2.875 74.304 238
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
local ID = require("scripts/zones/Windurst_Waters/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:sendGuild(530, 5, 20, 7)) then
        player:showText(npc, ID.text.KOPOPO_SHOP_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
