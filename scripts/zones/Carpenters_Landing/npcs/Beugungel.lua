-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Beugungel
-- Type: Guild Merchant NPC (Woodworking Guild)
-- !pos -333.729, -5.512, 475.647 2
-----------------------------------
local ID = zones[xi.zone.CARPENTERS_LANDING]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(534, 5, 22, 0) then
        player:showText(npc, ID.text.BEUGUNGEL_SHOP_DIALOG)
    end
end

return entity
