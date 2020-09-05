-----------------------------------
-- Area: Port Bastok
--  NPC: Blabbivix
-- Standard merchant, though he acts like a guild merchant
-- !pos -110.209 4.898 22.957 236
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
local ID = require("scripts/zones/Port_Bastok/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:sendGuild(60418, 11, 22, 3)) then
        player:showText(npc, ID.text.BLABBIVIX_SHOP_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
