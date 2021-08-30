-----------------------------------------
-- ID: 5243
-- Item: container_of_carnal_incense
-- Item Effect: When applied, grants UDMGPHYS -10000 for 20s
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
    local effect        = xi.effect.PHYSICAL_SHIELD
    local duration      = 20
    local power         = 1
    local mitigatews    = 2

    item_utils.addItemShield(target, power, duration, effect, mitigatews)
end

return item_object
