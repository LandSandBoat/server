-----------------------------------
-- ID: 4161
-- Item: Sleeping Potion
-- Item Effect: This potion induces sleep.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.SLEEP_I, { power = 1, duration = 30, origin = user })
end

return itemObject
