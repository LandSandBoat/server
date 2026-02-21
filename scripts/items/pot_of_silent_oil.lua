-----------------------------------
-- ID: 4165
-- Silent oil
-- This lubricant cuts down 99.99% of all friction
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if not target:hasStatusEffect(xi.effect.SNEAK) then
        target:addStatusEffect(xi.effect.SNEAK, { power = 1, duration = math.floor(600 * xi.settings.main.SNEAK_INVIS_DURATION_MULTIPLIER), origin = user, tick = 10 })
    end
end

return itemObject
