-----------------------------------
-- ID: 15320
-- Powder Boots
--  Enchantment: "Flee"
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    target:delStatusEffect(xi.effect.FLEE)
    target:addStatusEffect(xi.effect.FLEE, { power = 10000, duration = 30, origin = user })
end

return itemObject
