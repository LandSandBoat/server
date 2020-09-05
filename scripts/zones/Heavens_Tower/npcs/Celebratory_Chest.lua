-----------------------------------
-- Area: Heavens Tower
--  NPC: Celebratory Chest
-- Type: Merchant NPC
-- !pos -7.600 0.249 25.239 242
-----------------------------------
local ID = require("scripts/zones/Windurst_Walls/IDs")
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
