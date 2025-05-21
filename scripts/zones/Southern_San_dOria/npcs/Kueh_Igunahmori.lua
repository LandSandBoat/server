-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Kueh Igunahmori
-- Guild Merchant NPC: Leathercrafting Guild
-- !pos -194.791 -8.800 13.130 230
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(529, 3, 18, 4) then
        player:showText(npc, ID.text.KUEH_IGUNAHMORI_DIALOG)
    end
end

return entity
