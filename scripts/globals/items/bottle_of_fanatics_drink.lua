-----------------------------------------
-- ID: 5844
-- Item: bottle_of_fanatics_drink
-- Item Effect: When applied, grants UDMGPHYS -10000 for 60s
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
    local effect        = xi.effect.PHYSICAL_SHIELD
    local duration      = 60
    local power         = 1
    local mitigatews    = 1

    xi.item_utils.addItemShield(target, power, duration, effect, mitigatews)
end

return itemObject
