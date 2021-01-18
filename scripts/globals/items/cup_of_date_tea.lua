-----------------------------------
-- ID: 5926
-- Item: Cup of Date Tea
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- HP 20
-- MP 30
-- Vitality -1
-- Charisma 5
-- Intelligence 3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5926)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 20)
    target:addMod(tpz.mod.MP, 30)
    target:addMod(tpz.mod.VIT, -1)
    target:addMod(tpz.mod.CHR, 5)
    target:addMod(tpz.mod.INT, 3)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 20)
    target:delMod(tpz.mod.MP, 30)
    target:delMod(tpz.mod.VIT, -1)
    target:delMod(tpz.mod.CHR, 5)
    target:delMod(tpz.mod.INT, 3)
end

return item_object
