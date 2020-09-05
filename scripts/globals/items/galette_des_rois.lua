-----------------------------------------
-- ID: 5875
-- Item: Galette Des Rois
-- Food Effect: 180 Min, All Races
-----------------------------------------
-- HP +8
-- MP +3% (cap13)
-- Intelligence +2
-- Random Jewel
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    if target:getFreeSlotsCount() == 0 then
        result = tpz.msg.basic.ITEM_NO_USE_INVENTORY
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5875)
    local rand = math.random(784, 815)
    target:addItem(rand) -- Random Jewel
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 8)
    target:addMod(tpz.mod.FOOD_MPP, 3)
    target:addMod(tpz.mod.FOOD_MP_CAP, 13)
    target:addMod(tpz.mod.INT, 2)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 8)
    target:delMod(tpz.mod.FOOD_MPP, 3)
    target:delMod(tpz.mod.FOOD_MP_CAP, 13)
    target:delMod(tpz.mod.INT, 2)
end
