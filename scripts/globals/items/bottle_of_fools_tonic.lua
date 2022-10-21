-----------------------------------------
-- ID: 5846
-- Item: bottle_of_fools_tonic
-- Item Effect: When applied, grants DMGMAGIC -5000 for 60s
--              Does not Grant Spell Immunity (nospellimmune = 1)
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
    local effect        = xi.effect.MAGIC_SHIELD
    local duration      = 60
    local power         = 0
    local nospellimmune = 1

    xi.item_utils.addItemShield(target, power, duration, effect, nospellimmune)
end

return itemObject
