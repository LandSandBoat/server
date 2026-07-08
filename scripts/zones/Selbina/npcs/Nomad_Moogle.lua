-----------------------------------
-- Area: Selbina
--  NPC: Nomad Moogle
-----------------------------------
local ID = zones[xi.zone.SELBINA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.NOMAD_MOOGLE_DIALOG)
    player:sendMenu(xi.menuType.MOOGLE)
end

return entity
