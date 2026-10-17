-----------------------------------
-- ID: 57
-- Item: Cupboard
-----------------------------------
---@type TItemFurniture
local itemObject = {}

itemObject.onFurniturePlaced = function(player)
    if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.UNEXPECTED_TREASURE) == xi.questStatus.QUEST_AVAILABLE then
        player:setCharVar('Quest[0][70]cupboardPlacedTime', GetSystemTime())
        player:setCharVar('Quest[0][70]mustZone', 1)
    end
end

itemObject.onFurnitureRemoved = function(player)
    player:setCharVar('Quest[0][70]cupboardPlacedTime', 0)
end

return itemObject
