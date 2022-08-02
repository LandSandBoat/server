-----------------------------------
-- ID: 15452
-- Item: Fisherman's Belt
-- Enchantment: Synthesis image support
-- 2Min, All Races
-----------------------------------
-- Enchantment: Synthesis image support
-- Duration: 2Min
-- Fishing Skill +3
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    local imagery =
    {
        xi.effect.FISHING_IMAGERY,
        xi.effect.WOODWORKING_IMAGERY,
        xi.effect.SMITHING_IMAGERY,
        xi.effect.GOLDSMITHING_IMAGERY,
        xi.effect.CLOTHCRAFT_IMAGERY,
        xi.effect.LEATHERCRAFT_IMAGERY,
        xi.effect.BONECRAFT_IMAGERY,
        xi.effect.ALCHEMY_IMAGERY,
        xi.effect.COOKING_IMAGERY
    }

    for _, effect in ipairs(imagery) do
        if (target:hasStatusEffect(effect)) then
            result = xi.msg.basic.ITEM_UNABLE_TO_USE
        end
    end

    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FISHING_IMAGERY, 3, 0, 120)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FISH, 1)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FISH, 1)
end

return item_object
