-----------------------------------
-- Area: Norg
--  NPC: Nomad Moogle
-----------------------------------
local ID = zones[xi.zone.NORG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.NOMAD_MOOGLE_DIALOG)
    player:sendMenu(xi.menuType.MOOGLE)
end

return entity
