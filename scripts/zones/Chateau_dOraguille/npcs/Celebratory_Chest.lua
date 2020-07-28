-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Celebratory Chest
-- Type: Merchant NPC
-- !pos -6.036 0.000 3.998 233
-----------------------------------
local ID = require("scripts/zones/Chateau_dOraguille/IDs")
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
