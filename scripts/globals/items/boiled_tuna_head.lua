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
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) or target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD) then
        result = xi.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4540)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 20)
    target:addMod(xi.mod.DEX, 3)
    target:addMod(xi.mod.INT, 4)
    target:addMod(xi.mod.MND, -3)
    target:addMod(xi.mod.MPHEAL, 2)
    target:addMod(xi.mod.EVA, 5)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 20)
    target:delMod(xi.mod.DEX, 3)
    target:delMod(xi.mod.INT, 4)
    target:delMod(xi.mod.MND, -3)
    target:delMod(xi.mod.MPHEAL, 2)
    target:delMod(xi.mod.EVA, 5)
end

return item_object
