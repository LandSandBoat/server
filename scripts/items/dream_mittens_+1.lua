-----------------------------------
-- ID: 10383
-- Item: Dream Mittens +1
-- Enchantment: Invisible
-- Duration: 3 Mins 20 Secs
-- TODO: Enhances duration of Invisible Effect
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if not target:hasStatusEffect(xi.effect.INVISIBLE) then
        target:addStatusEffect(xi.effect.INVISIBLE, { duration = math.floor(200 * xi.settings.main.SNEAK_INVIS_DURATION_MULTIPLIER), origin = user, tick = 10 })
    end
end

return itemObject
