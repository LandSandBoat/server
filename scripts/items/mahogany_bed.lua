-----------------------------------
-- ID: 4
-- Item: Mahogany Bed
-----------------------------------
---@type TItemFurniture
local itemObject = {}

itemObject.onFurniturePlaced = function(player)
    if player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.THE_MOOGLE_PICNIC) == xi.questStatus.QUEST_AVAILABLE then
        xi.quest.setVar(player, xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.THE_MOOGLE_PICNIC, 'bedPlacedTime', GetSystemTime())
        xi.quest.setLocalVar(player, xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.THE_MOOGLE_PICNIC, 'mustZone', 1)
    end
end

itemObject.onFurnitureRemoved = function(player)
    xi.quest.setVar(player, xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.THE_MOOGLE_PICNIC, 'bedPlacedTime', 0)
end

return itemObject
