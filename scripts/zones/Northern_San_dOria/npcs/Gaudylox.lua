-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Gaudylox
-- Standard merchant, though he acts like a guild merchant
-- !pos -147.593 11.999 222.550 231
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(60418, 11, 22, 0) then
        player:showText(npc, ID.text.GAUDYLOX_SHOP_DIALOG)
    end
end

return entity
