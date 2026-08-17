-----------------------------------
-- ID: 6
-- Item: Noble's Bed
-----------------------------------
---@type TItemFurniture
local itemObject = {}

itemObject.onFurniturePlaced = function(player)
    if player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.MOOGLES_IN_THE_WILD) == xi.questStatus.QUEST_AVAILABLE then
        xi.quest.setVar(player, xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.MOOGLES_IN_THE_WILD, 'bedPlacedTime', GetSystemTime())
        xi.quest.setLocalVar(player, xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.MOOGLES_IN_THE_WILD, 'mustZone', 1)
    end
end

itemObject.onFurnitureRemoved = function(player)
    xi.quest.setVar(player, xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.MOOGLES_IN_THE_WILD, 'bedPlacedTime', 0)
end

return itemObject
