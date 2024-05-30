-----------------------------------
-- ID: 15448
-- Item: Tanners belt
-- Enchantment: Synthesis image support
-- 8Min, All Races
-----------------------------------
-- Enchantment: Synthesis image support
-- Duration: 8Min
-- Leathercraft Skill +3
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local result = 0
    if target:hasStatusEffect(xi.effect.LEATHERCRAFT_IMAGERY) then
        result = 240
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.LEATHERCRAFT_IMAGERY, 3, 0, 480)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.LEATHER, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.LEATHER, 1)
end

return itemObject
