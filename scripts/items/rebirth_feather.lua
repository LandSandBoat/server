-----------------------------------
-- ID: 5259
-- Item: Rebirth Feather
-- Status Effect: Reraise II
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
    -- * No Raise        - 26740 -> 25114 = 1626 lost
    -- * Rebirth Feather - 25114 -> 24707 = 407 lost (25%)
    target:addStatusEffect(xi.effect.RERAISE, { power = 2, duration = duration, origin = user })
    target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.RERAISE)
end

return itemObject
