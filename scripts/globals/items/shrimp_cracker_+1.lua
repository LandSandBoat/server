-----------------------------------------
-- ID: 5636
-- Item: shrimp_cracker_+1
-- Food Effect: 5Min, All Races
-----------------------------------------
-- Vitality 2
-- Defense +10
-- Amorph Killer 12
-- Resist Virus 12
-- HP Recovered While Healing 9
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 5636)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.DEF, 10)
    target:addMod(tpz.mod.AMORPH_KILLER, 12)
    target:addMod(tpz.mod.VIRUSRES, 12)
    target:addMod(tpz.mod.HPHEAL, 9)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.DEF, 10)
    target:delMod(tpz.mod.AMORPH_KILLER, 12)
    target:delMod(tpz.mod.VIRUSRES, 12)
    target:delMod(tpz.mod.HPHEAL, 9)
end

return item_object
