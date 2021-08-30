-----------------------------------------
-- ID: 5850
-- Item: bottle_of_swiftshot_drink
-- Item Effect: Double Shot +100
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
    local effect    = xi.effect.MULTI_SHOTS
    local power     = 100 --Double Shot Rate
    local duration  =  60

    item_utils.addItemEffect(target, effect, power, duration)
end

return item_object
