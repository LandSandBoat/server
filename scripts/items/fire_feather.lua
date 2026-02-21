-----------------------------------
-- ID: 5256
-- Item: Fire Feather
-- Status Effect: Enfire
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.ENFIRE, { power = 10, duration = 180, origin = user }) -- This is a guess, no potency or duration info is known
end

return itemObject
