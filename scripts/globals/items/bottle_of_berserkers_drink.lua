-----------------------------------------
-- ID: 5849
-- Item: bottle_of_berserkers_drink
-- Item Effect: Double Attack +100
-----------------------------------------
require("scripts/globals/msg")
require("scripts/globals/item_utils")
-----------------------------------------

local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local effect    = xi.effect.MULTI_STRIKES
    local power     = 100 --DA
    local duration  =  60

    xi.item_utils.addItemEffect(target, effect, power, duration)
end

return itemObject
