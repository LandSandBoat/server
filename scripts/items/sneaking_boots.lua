-----------------------------------
--  ID: 15698
--  Sneaking Boots
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    target:delStatusEffect(xi.effect.SNEAK)
    target:addStatusEffect(xi.effect.SNEAK, { power = 1, duration = math.floor(180 * xi.settings.main.SNEAK_INVIS_DURATION_MULTIPLIER), origin = user })
end

return itemObject
