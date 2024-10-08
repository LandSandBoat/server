-----------------------------------
-- ID: 5259
-- Item: Rebirth Feather
-- Status Effect: Reraise III
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    local duration = 7200
    target:delStatusEffect(xi.effect.RERAISE)
    target:addStatusEffect(xi.effect.RERAISE, 3, 0, duration)
    target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.RERAISE)
end

return itemObject
