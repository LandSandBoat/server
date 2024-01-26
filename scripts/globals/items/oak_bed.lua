-----------------------------------
-- ID: 3
-- Item: Oak Bed
-----------------------------------
require("scripts/globals/furniture_quests")
-----------------------------------
local itemObject = {}

itemObject.onFurniturePlaced = function(player, item)
    xi.furnitureQuests.onFurniturePlaced(player, item)
end

itemObject.onFurnitureRemoved = function(player, item)
    xi.furnitureQuests.onFurnitureRemoved(player, item)
end

return itemObject
