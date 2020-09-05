-----------------------------------------
-- ID: 5674
-- Item: Aileen's Delight
-- Food Effect: 60 Min, All Races
-----------------------------------------
-- HP +50
-- MP +50
-- STR +4
-- DEX +4
-- VIT +4
-- AGI +4
-- INT +4
-- MND +4
-- CHR +4
-- MP recovered while healing +2
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD)) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5674)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 50)
    target:addMod(tpz.mod.MP, 50)
    target:addMod(tpz.mod.STR, 4)
    target:addMod(tpz.mod.DEX, 4)
    target:addMod(tpz.mod.VIT, 4)
    target:addMod(tpz.mod.AGI, 4)
    target:addMod(tpz.mod.INT, 4)
    target:addMod(tpz.mod.MND, 4)
    target:addMod(tpz.mod.CHR, 4)
    target:addMod(tpz.mod.MPHEAL, 2)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 50)
    target:delMod(tpz.mod.MP, 50)
    target:delMod(tpz.mod.STR, 4)
    target:delMod(tpz.mod.DEX, 4)
    target:delMod(tpz.mod.VIT, 4)
    target:delMod(tpz.mod.AGI, 4)
    target:delMod(tpz.mod.INT, 4)
    target:delMod(tpz.mod.MND, 4)
    target:delMod(tpz.mod.CHR, 4)
    target:delMod(tpz.mod.MPHEAL, 2)
end
