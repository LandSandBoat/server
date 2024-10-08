-----------------------------------
-- ID: 5
-- Item: Bronze Bed
-----------------------------------
---@type TItemFurniture
local itemObject = {}

itemObject.onFurniturePlaced = function(player)
    if player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.GIVE_A_MOOGLE_A_BREAK) == xi.questStatus.QUEST_AVAILABLE then
        player:setCharVar('Quest[4][100]bedPlacedTime', os.time())
        player:setLocalVar('Quest[4][100]mustZone', 1)
    end
end

itemObject.onFurnitureRemoved = function(player)
    player:setCharVar('Quest[4][100]bedPlacedTime', 0)
end

return itemObject
