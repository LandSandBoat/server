-----------------------------------
-- ID: 15449
-- Item: Boneworker's belt
-- Enchantment: Synthesis image support
-- 2Min, All Races
-----------------------------------
-- Enchantment: Synthesis image support
-- Duration: 2Min
-- Bonecraft Skill +3
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.BONECRAFT_IMAGERY) then
        result = 241
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.BONECRAFT_IMAGERY, 3, 0, 120)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.BONE, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.BONE, 1)
end

return itemObject
