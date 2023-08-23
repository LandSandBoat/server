-----------------------------------
-- ID: 15447
-- Item: Weaver's Belt
-- Enchantment: Synthesis image support
-- 2Min, All Races
-----------------------------------
-- Enchantment: Synthesis image support
-- Duration: 2Min
-- Clothcraft Skill +3
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.CLOTHCRAFT_IMAGERY) then
        result = 239
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.CLOTHCRAFT_IMAGERY, 3, 0, 120)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.CLOTH, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.CLOTH, 1)
end

return itemObject
