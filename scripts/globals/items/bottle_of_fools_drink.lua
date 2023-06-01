-----------------------------------------
-- ID: 5435
-- Item: bottle_of_fools_drink
-- Item Effect: When applied, grants UDMGMAGIC -10000 for 60s
-----------------------------------------
require("scripts/globals/msg")
require("scripts/globals/item_utils")
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local effect        = xi.effect.MAGIC_SHIELD
    local duration      = 60
    local power         = 1
    local nospellimmune = 0

    xi.item_utils.addItemShield(target, power, duration, effect, nospellimmune)
end

return itemObject
