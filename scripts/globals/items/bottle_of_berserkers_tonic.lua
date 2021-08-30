-----------------------------------------
-- ID: 5851
-- Item: bottle_of_berserkers_tonic
-- Item Effect: Double Attack +50
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/item_utils")
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local effect    = xi.effect.MULTI_STRIKES
    local power     = 50 --DA
    local duration  = 60

    item_utils.addItemEffect(target, effect, power, duration)
end

return item_object
