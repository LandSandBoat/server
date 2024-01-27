-----------------------------------
-- ID: 5845
-- Item: bottle_of_fanatics_tonic
-- Item Effect: When applied, grants DMGPHYS -5000 for 60s
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local effect        = xi.effect.PHYSICAL_SHIELD
    local duration      = 60
    local power         = 0
    local mitigatews    = 0

    xi.itemUtils.addItemShield(target, power, duration, effect, mitigatews)
end

return itemObject
