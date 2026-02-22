-----------------------------------
--  ID: 16003
--  Reraise Earring
--  This earring functions in the same way as the spell Reraise.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    local duration = 2100
    target:delStatusEffect(xi.effect.RERAISE)
    target:addStatusEffect(xi.effect.RERAISE, { power = 1, duration = duration, origin = user })
end

return itemObject
