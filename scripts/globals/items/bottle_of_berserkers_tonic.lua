-----------------------------------------
-- ID: 5851
-- Item: bottle_of_berserkers_tonic
-- Item Effect: Double Attack +50
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/item_utils")
-----------------------------------------

local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local effect    = xi.effect.MULTI_STRIKES
    local power     = 50 --DA
    local duration  = 60

    xi.item_utils.addItemEffect(target, effect, power, duration)
end

return itemObject
