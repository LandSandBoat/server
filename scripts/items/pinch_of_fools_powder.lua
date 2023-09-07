-----------------------------------
-- ID: 5848
-- Item: pinch_of_fools_powder
-- Item Effect: When applied, grants UDMGMAGIC -10000 to party members in range for 60s
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local effect        = xi.effect.MAGIC_SHIELD
    local duration      = 60
    local power         = 1
    local nospellimmune = 0

    target:forMembersInRange(20, function(member)
        xi.itemUtils.addItemShield(member, power, duration, effect, nospellimmune)
    end)
end

return itemObject
