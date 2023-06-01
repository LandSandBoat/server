-----------------------------------------
-- ID: 5244
-- Item: container_of_spiritual_incense
-- Item Effect: When applied, grants UDMGMAGIC -10000 for 20s
--              Does not Grant Spell Immunity (nospellimmune = 1)
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
    local duration      = 20
    local power         = 1
    local nospellimmune = 1

    xi.item_utils.addItemShield(target, power, duration, effect, nospellimmune)
end

return itemObject
