-----------------------------------
-- ID: 61
-- Item: Armoire
-- xi.item.ARMOIRE
-----------------------------------
---@type TItemFurniture
local itemObject = {}

itemObject.onFurniturePlaced = function(player)
    if player:getCharVar('HQuest[FurnitureQuest_Armoire]RewardObtained') == 0 then
        player:setCharVar('HQuest[FurnitureQuest_Armoire]PlacedTime', GetSystemTime())
        player:setLocalVar('HQuest[FurnitureQuest_Armoire]MustZone', 1)
    end
end

itemObject.onFurnitureRemoved = function(player)
    player:setCharVar('HQuest[FurnitureQuest_Armoire]placedTime', 0)
end

return itemObject
