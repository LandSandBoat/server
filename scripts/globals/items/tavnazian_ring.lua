-----------------------------------------
-- ID: 14672
-- Tavnazian Ring
-- Enchantment: "Teleport-Tavnazia"
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    target:setPos(0, -23.5, 29.15, 63, 26)
end

return item_object
