-----------------------------------
-- ID: 4
-- Item: Mahogany Bed
-----------------------------------
local itemObject = {}

itemObject.onFurniturePlaced = function(player)
    if player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_MOOGLE_PICNIC) == QUEST_AVAILABLE then
        player:setCharVar('Quest[4][101]bedPlacedTime', os.time())
        player:setLocalVar('Quest[4][101]mustZone', 1)
    end
end

itemObject.onFurnitureRemoved = function(player)
    player:setCharVar('Quest[4][101]bedPlacedTime', 0)
end

return itemObject
