-----------------------------------
-- ID: 18398
-- Raphael's Rod
-- Grants Reraise III.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    target:delStatusEffect(xi.effect.RERAISE)
    target:addStatusEffect(xi.effect.RERAISE, { power = 3, duration = 7200, origin = user })
    target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.RERAISE)
end

return itemObject
