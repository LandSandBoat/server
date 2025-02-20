-----------------------------------
-- Area: Windurst Woods
--  NPC: Anillah
-- Type: Clothcraft Image Support
-- !pos -34.800 -2.25 -119.950 241
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.crafting.oldImageSupportOnTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.crafting.oldImageSupportOnEventFinish(player, csid, option, npc)
end

return entity
