-----------------------------------
-- ID: 5635
-- Item: shrimp_cracker
-- Food Effect: 3Min, All Races
-----------------------------------
-- Vitality 1
-- DEF +10
-- Amorph Killer 10
-- Resist Virus +10
-- HP Recovered While Healing 8
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 180, 5635)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.VIT, 1)
    target:addMod(tpz.mod.DEF, 10)
    target:addMod(tpz.mod.AMORPH_KILLER, 10)
    target:addMod(tpz.mod.VIRUSRES, 10)
    target:addMod(tpz.mod.HPHEAL, 8)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.VIT, 1)
    target:delMod(tpz.mod.DEF, 10)
    target:delMod(tpz.mod.AMORPH_KILLER, 10)
    target:delMod(tpz.mod.VIRUSRES, 10)
    target:delMod(tpz.mod.HPHEAL, 8)
end

return item_object
