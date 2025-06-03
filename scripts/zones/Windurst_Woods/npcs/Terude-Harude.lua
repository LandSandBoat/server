-----------------------------------
-- Area: Windurst Woods
--  NPC: Terude-Harude
-- Type: Clothcraft Adv. Image Support
-- !pos -32.350 -2.679 -116.450 241
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
