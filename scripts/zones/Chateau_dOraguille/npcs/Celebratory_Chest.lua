-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Celebratory Chest
-- Type: Merchant NPC
-- !pos -6.036 0.000 3.998 233
-----------------------------------
local ID = zones[xi.zone.CHATEAU_DORAGUILLE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.shop.celebratory(player)
    player:messageSpecial(ID.text.CELEBRATORY_GOODS)
end

return entity
