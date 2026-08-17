-----------------------------------
-- ID: 5
-- Item: Bronze Bed
-----------------------------------
---@type TItemFurniture
local itemObject = {}

itemObject.onFurniturePlaced = function(player)
    if player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.GIVE_A_MOOGLE_A_BREAK) == xi.questStatus.QUEST_AVAILABLE then
        xi.quest.setVar(player, xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.GIVE_A_MOOGLE_A_BREAK, 'bedPlacedTime', GetSystemTime())
        xi.quest.setLocalVar(player, xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.GIVE_A_MOOGLE_A_BREAK, 'mustZone', 1)
    end
end

itemObject.onFurnitureRemoved = function(player)
    xi.quest.setVar(player, xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.GIVE_A_MOOGLE_A_BREAK, 'bedPlacedTime', 0)
end

return itemObject
