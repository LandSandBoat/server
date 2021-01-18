-----------------------------------
-- ID: 5960
-- Item: Ulbukan Lobster
-- Food Effect: 5 Min, Mithra only
-----------------------------------
-- Dexterity -3
-- Vitality 1
-- Defense +9%
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if (target:getRace() ~= tpz.race.MITHRA) then
        result = tpz.msg.basic.CANNOT_EAT
    end
    if (target:getMod(tpz.mod.EAT_RAW_FISH) == 1) then
        result = 0
    end
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 5960)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.DEX, -3)
    target:addMod(tpz.mod.VIT, 1)
    target:addMod(tpz.mod.DEFP, 9)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.DEX, -3)
    target:delMod(tpz.mod.VIT, 1)
    target:delMod(tpz.mod.DEFP, 9)
end

return item_object
