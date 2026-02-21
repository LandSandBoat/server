-----------------------------------
-- ID: 5770
-- Item: Super Reraiser
-- Item Effect: This potion functions the same way as the spell Reraise.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    local duration = 3600
    target:delStatusEffect(xi.effect.RERAISE)
    target:addStatusEffect(xi.effect.RERAISE, { power = 3, duration = duration, origin = user })
end

return itemObject
