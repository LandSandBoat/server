-----------------------------------
-- Area: Metalworks
--  NPC: Celebratory Chest
-- Type: Merchant NPC
-- !pos 88.029 -20.170 -11.086 237
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.shop.celebratory(player)
    player:messageSpecial(ID.text.CELEBRATORY_GOODS)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
