-----------------------------------
-- Area: Windurst Walls
--  NPC: Scavnix
-- Standard merchant, though he acts like a guild merchant
-- !pos 17.731 0.106 239.626 239
-----------------------------------
local ID = zones[xi.zone.WINDURST_WALLS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if xi.guildShops.onTrigger(player, npc) then
        player:showText(npc, ID.text.SCAVNIX_SHOP_DIALOG)
    end
end

return entity
