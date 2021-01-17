-----------------------------------------
-- ID: 5738
-- Item: chunk_of_sweet_lizard
-- Food Effect: 30Min, All Races
-----------------------------------------
-- HP 5
-- MP 5
-- Dexterity 1
-- hHP +2
-- hMP +2
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5738)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 5)
    target:addMod(tpz.mod.MP, 5)
    target:addMod(tpz.mod.DEX, 1)
    target:addMod(tpz.mod.HPHEAL, 2)
    target:addMod(tpz.mod.MPHEAL, 2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 5)
    target:delMod(tpz.mod.MP, 5)
    target:delMod(tpz.mod.DEX, 1)
    target:delMod(tpz.mod.HPHEAL, 2)
    target:delMod(tpz.mod.MPHEAL, 2)
end

return item_object
