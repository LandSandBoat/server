-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Chaupire
-- Guild Merchant NPC: Woodworking Guild
-- !pos -174.476 3.999 281.854 231
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(5132, 6, 21, 0) then
        player:showText(npc, ID.text.CHAUPIRE_SHOP_DIALOG)
    end
end

return entity
