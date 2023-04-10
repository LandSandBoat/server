-----------------------------------------
-- ID: 5852
-- Item: bottle_of_swiftshot_tonic
-- Item Effect: Double Shot +50
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
    local effect    = xi.effect.MULTI_SHOTS
    local power     = 50 --Double Shot Rate
    local duration  = 60

    xi.item_utils.addItemEffect(target, effect, power, duration)
end

return itemObject
