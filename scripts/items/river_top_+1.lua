-----------------------------------
-- ID: 10270
-- River Top +1
-- Dispense: Berry Snowcone
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.BERRY_SNOW_CONE, 1)
end

return itemObject
