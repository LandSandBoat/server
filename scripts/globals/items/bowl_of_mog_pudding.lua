-----------------------------------------
-- ID: 6009
-- Item: Bowl of Mog Pudding
-- Food Effect: 30Min, All Races
-----------------------------------------
-- HP 7
-- MP 7
-- Vitality 3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 6009)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 7)
    target:addMod(tpz.mod.MP, 7)
    target:addMod(tpz.mod.VIT, 3)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 7)
    target:delMod(tpz.mod.MP, 7)
    target:delMod(tpz.mod.VIT, 3)
end

return item_object
