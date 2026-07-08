-----------------------------------
-- ID: 5258
-- Item: Revive Feather
-- Status Effect: Reraise
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    local duration = 28800 -- 8 hours
    target:delStatusEffect(xi.effect.RERAISE)
    -- Test EXP
    -- * No Raise       - 26740 -> 25114 = 1626 lost
    -- * Revive Feather - 27553 -> 26740 = 813 lost (50%)
    target:addStatusEffect(xi.effect.RERAISE, { power = 1, duration = duration, origin = user })
    target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.RERAISE)
end

return itemObject
