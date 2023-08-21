-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Celebratory Chest
-- Type: Merchant NPC
-- !pos -6.036 0.000 3.998 233
-----------------------------------
local ID = zones[xi.zone.CHATEAU_DORAGUILLE]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.shop.celebratory(player)
    player:messageSpecial(ID.text.CELEBRATORY_GOODS)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
