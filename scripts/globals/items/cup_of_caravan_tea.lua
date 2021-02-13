-----------------------------------
-- ID: 5927
-- Item: Cup of Caravan Tea
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- HP 22
-- MP 32
-- Charisma 6
-- Intelligence 4
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5927)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 22)
    target:addMod(tpz.mod.MP, 32)
    target:addMod(tpz.mod.CHR, 6)
    target:addMod(tpz.mod.INT, 4)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 22)
    target:delMod(tpz.mod.MP, 32)
    target:delMod(tpz.mod.CHR, 6)
    target:delMod(tpz.mod.INT, 4)
end

return item_object
