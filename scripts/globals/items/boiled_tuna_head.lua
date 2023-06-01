-----------------------------------
-- ID: 4540
-- Item: Boiled Tuna Head
-- Food Effect: 180Min, All Races
-----------------------------------
-- Magic 20
-- Dexterity 3
-- Intelligence 4
-- Mind -3
-- Magic Regen While Healing 2
-- Evasion 5
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4540)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 20)
    target:addMod(xi.mod.DEX, 3)
    target:addMod(xi.mod.INT, 4)
    target:addMod(xi.mod.MND, -3)
    target:addMod(xi.mod.MPHEAL, 2)
    target:addMod(xi.mod.EVA, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 20)
    target:delMod(xi.mod.DEX, 3)
    target:delMod(xi.mod.INT, 4)
    target:delMod(xi.mod.MND, -3)
    target:delMod(xi.mod.MPHEAL, 2)
    target:delMod(xi.mod.EVA, 5)
end

return itemObject
