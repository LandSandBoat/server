-----------------------------------
-- Area: Windurst Walls
--  NPC: Scavnix
-- Standard merchant, though he acts like a guild merchant
-- !pos 17.731 0.106 239.626 239
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
local ID = require("scripts/zones/Windurst_Walls/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:sendGuild(60418, 11, 22, 6)) then
        player:showText(npc, ID.text.SCAVNIX_SHOP_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
