-----------------------------------
--
-- tpz.effect.FIELD_SUPPORT_FOOD
-- From FoV and GoV
-----------------------------------

function onEffectGain(target, effect)
    if (effect:getPower() == 1) then -- Dried Meat
        target:addMod(tpz.mod.STR, 4)
        target:addMod(tpz.mod.FOOD_ATTP, 22)
        target:addMod(tpz.mod.FOOD_ATT_CAP, 63)
    elseif (effect:getPower() == 2) then -- Salted Fish
        target:addMod(tpz.mod.VIT, 2)
        target:addMod(tpz.mod.FOOD_DEFP, 30)
        target:addMod(tpz.mod.FOOD_DEF_CAP, 86)
    elseif (effect:getPower() == 3) then -- Hard Cookie
        target:addMod(tpz.mod.INT, 4)
        target:addMod(tpz.mod.MP, 30)
    elseif (effect:getPower() == 4) then -- Instant Noodles
        target:addMod(tpz.mod.VIT, 1)
        target:addMod(tpz.mod.FOOD_HPP, 27)
        target:addMod(tpz.mod.FOOD_HP_CAP, 75)
        target:addMod(tpz.mod.STORETP, 5)
    elseif (effect:getPower() == 5) then -- Dried Agaricus
        target:addMod(tpz.mod.MND, 4)
    elseif (effect:getPower() == 6) then -- Instant Rice
        target:addMod(tpz.mod.CHR, 6)
    elseif (effect:getPower() == 255) then -- ACP Seed Goblin Saucepan Attack
        -- Based on info from http://www.bg-wiki.com/bg/Seed_Goblin
        target:addMod(tpz.mod.STR, -10)
        target:addMod(tpz.mod.DEX, -10)
        target:addMod(tpz.mod.VIT, -10)
        target:addMod(tpz.mod.AGI, -10)
        target:addMod(tpz.mod.INT, -10)
        target:addMod(tpz.mod.MND, -10)
        target:addMod(tpz.mod.CHR, -10)
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    if (effect:getPower() == 1) then -- Dried Meat
        target:delMod(tpz.mod.STR, 4)
        target:delMod(tpz.mod.FOOD_ATTP, 22)
        target:delMod(tpz.mod.FOOD_ATT_CAP, 63)
    elseif (effect:getPower() == 2) then -- Salted Fish
        target:delMod(tpz.mod.VIT, 2)
        target:delMod(tpz.mod.FOOD_DEFP, 30)
        target:delMod(tpz.mod.FOOD_DEF_CAP, 86)
    elseif (effect:getPower() == 3) then -- Hard Cookie
        target:delMod(tpz.mod.INT, 4)
        target:delMod(tpz.mod.MP, 30)
    elseif (effect:getPower() == 4) then -- Instant Noodles
        target:delMod(tpz.mod.VIT, 1)
        target:delMod(tpz.mod.FOOD_HPP, 27)
        target:delMod(tpz.mod.FOOD_HP_CAP, 75)
        target:delMod(tpz.mod.STORETP, 5)
    elseif (effect:getPower() == 5) then -- Dried Agaricus
        target:delMod(tpz.mod.MND, 4)
    elseif (effect:getPower() == 6) then -- Instant Rice
        target:delMod(tpz.mod.CHR, 6)
    elseif (effect:getPower() == 255) then -- ACP Seed Goblin Saucepan Attack
        -- Based on info from http://www.bg-wiki.com/bg/Seed_Goblin
        target:delMod(tpz.mod.STR, -10)
        target:delMod(tpz.mod.DEX, -10)
        target:delMod(tpz.mod.VIT, -10)
        target:delMod(tpz.mod.AGI, -10)
        target:delMod(tpz.mod.INT, -10)
        target:delMod(tpz.mod.MND, -10)
        target:delMod(tpz.mod.CHR, -10)
    end
end
