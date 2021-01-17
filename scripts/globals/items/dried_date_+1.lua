-----------------------------------------
-- ID: 5574
-- Item: dried_date_+1
-- Food Effect: 60Min, All Races
-----------------------------------------
-- Health 12
-- Magic 22
-- Agility -1
-- Intelligence 4
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5574)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 12)
    target:addMod(tpz.mod.MP, 22)
    target:addMod(tpz.mod.AGI, -1)
    target:addMod(tpz.mod.INT, 4)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 12)
    target:delMod(tpz.mod.MP, 22)
    target:delMod(tpz.mod.AGI, -1)
    target:delMod(tpz.mod.INT, 4)
end

return item_object
