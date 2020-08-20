-----------------------------------
-- Area: Bastok Mines
--  NPC: Maymunah
-- Guild Merchant NPC: Alchemy Guild
-- !pos 108.738 5.017 -3.129 234
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
local ID = require("scripts/zones/Bastok_Mines/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:sendGuild(5262, 8, 23, 6)) then
        player:showText(npc, ID.text.MAYMUNAH_SHOP_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
