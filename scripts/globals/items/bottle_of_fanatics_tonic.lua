-----------------------------------------
-- ID: 5845
-- Item: bottle_of_fanatics_tonic
-- Item Effect: When applied, grants DMGPHYS -5000 for 60s
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
    local duration      = 60
    local power         = 0
    local mitigatews    = 0

    item_utils.addItemShield(target, power, duration, effect, mitigatews)
end

return item_object
