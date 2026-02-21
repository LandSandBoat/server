-----------------------------------
-- Area: Abyssea - Empyreal Paradox
--  NPC: Cruor Prospector
-- !pos 535.000 -500.500 -584.000 255
-----------------------------------
---@type TNpcEntity
local entity = {}

local localProspectorItems =
{
    [xi.abyssea.itemType.TEMP       ] = xi.abyssea.visionsCruorProspectorTemps,
    [xi.abyssea.itemType.ENHANCEMENT] = xi.abyssea.visionsCruorProspectorBuffs,
}

entity.onTrigger = function(player, npc)
    xi.abyssea.visionsCruorProspectorOnTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.visionsCruorProspectorOnEventFinish(player, csid, option, localProspectorItems)
end

return entity
