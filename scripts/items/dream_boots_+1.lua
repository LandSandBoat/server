-----------------------------------
-- ID: 15753
-- Item: Dream Boots +1
-- Enchantment: Sneak
-- Duration: 3 Mins 20 Secs
-- TODO: Enhances duration of Sneak Effect
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if not target:hasStatusEffect(xi.effect.SNEAK) then
        target:addStatusEffect(xi.effect.SNEAK, { power = 1, duration = math.floor(200 * xi.settings.main.SNEAK_INVIS_DURATION_MULTIPLIER), origin = user, tick = 10 })
    end
end

return itemObject
