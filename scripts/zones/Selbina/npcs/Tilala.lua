-----------------------------------
-- Area: Selbina
--  NPC: Tilala
-- Guild Merchant NPC: Clothcrafting Guild
-- !pos 14.344 -7.912 10.276 248
-----------------------------------
local ID = require("scripts/zones/Selbina/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:sendGuild(516, 6, 21, 0) then
        player:showText(npc, ID.text.CLOTHCRAFT_SHOP_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
