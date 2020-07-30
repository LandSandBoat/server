-----------------------------------
-- Area: Windurst Woods
--  NPC: Kuzah Hpirohpon
-- Guild Merchant NPC: Clothcrafting Guild
-- !pos -80.068 -3.25 -127.686 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:sendGuild(5152, 6, 21, 0)) then
        player:showText(npc, ID.text.KUZAH_HPIROHPON_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
