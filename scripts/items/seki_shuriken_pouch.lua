-----------------------------------
-- ID: 6415
-- Seki Shuriken Pouch
-- When used, you will obtain one stack of Seki Shurikens
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.SEKI_SHURIKEN, 99)
end

return itemObject
