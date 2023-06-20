-----------------------------------
-- ID: 4542
-- Item: Bowl of Brain Stew
-- Food Effect: 180Min, All Races
-----------------------------------
-- Dexterity 5
-- Intelligence 5
-- Mind 5
-- Health Regen While Healing 3
-- Magic Regen While Healing 3
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4542)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 5)
    target:addMod(xi.mod.INT, 5)
    target:addMod(xi.mod.MND, 5)
    target:addMod(xi.mod.HPHEAL, 3)
    target:addMod(xi.mod.MPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 5)
    target:delMod(xi.mod.INT, 5)
    target:delMod(xi.mod.MND, 5)
    target:delMod(xi.mod.HPHEAL, 3)
    target:delMod(xi.mod.MPHEAL, 3)
end

return itemObject
