-----------------------------------
-- ID: 15452
-- Item: Fisherman's belt
-- Enchantment: Fishing image support
-- 2 hours, All Races
-----------------------------------
-- Enchantment: Fishing image support
-- Duration: 2 hours
-- Fishing Skill +2
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FISHING_IMAGERY) == true then
        result = xi.effect.FISHING_IMAGERY
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FISHING_IMAGERY, 2, 0, 7200)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FISH, 1)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FISH, 1)
end

return item_object
