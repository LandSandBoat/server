-----------------------------------------
-- ID: 5848
-- Item: pinch_of_fools_powder
-- Item Effect: When applied, grants UDMGMAGIC -10000 to party members in range for 60s
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
    local effect        = xi.effect.MAGIC_SHIELD
    local duration      = 60
    local power         = 1
    local nospellimmune = 0

    target:forMembersInRange(20, function(member)
        xi.item_utils.addItemShield(member, power, duration, effect, nospellimmune)
    end)
end

return item_object
