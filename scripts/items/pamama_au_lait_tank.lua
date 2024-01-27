-----------------------------------
-- ID: 16226
-- Pamama Tank
-- When used, you will obtain one Pamama au lait
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.FLASK_OF_PAMAMA_AU_LAIT, 1)
end

return itemObject
