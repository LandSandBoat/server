-----------------------------------
-- xi.effect.FIELD_SUPPORT_FOOD
-- From FoV and GoV
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if effect:getPower() == 1 then -- Dried Meat
        target:addMod(xi.mod.STR, 4)
        target:addMod(xi.mod.FOOD_ATTP, 22)
        target:addMod(xi.mod.FOOD_ATT_CAP, 63)
    elseif effect:getPower() == 2 then -- Salted Fish
        target:addMod(xi.mod.VIT, 2)
        target:addMod(xi.mod.FOOD_DEFP, 30)
        target:addMod(xi.mod.FOOD_DEF_CAP, 86)
    elseif effect:getPower() == 3 then -- Hard Cookie
        target:addMod(xi.mod.INT, 4)
        target:addMod(xi.mod.MP, 30)
    elseif effect:getPower() == 4 then -- Instant Noodles
        target:addMod(xi.mod.VIT, 1)
        target:addMod(xi.mod.FOOD_HPP, 27)
        target:addMod(xi.mod.FOOD_HP_CAP, 75)
        target:addMod(xi.mod.STORETP, 5)
    elseif effect:getPower() == 5 then -- Dried Agaricus
        target:addMod(xi.mod.MND, 4)
    elseif effect:getPower() == 6 then -- Instant Rice
        target:addMod(xi.mod.CHR, 6)
    elseif effect:getPower() == 255 then -- ACP Seed Goblin Saucepan Attack
        -- Based on info from http://www.bg-wiki.com/bg/Seed_Goblin
        target:addMod(xi.mod.STR, -10)
        target:addMod(xi.mod.DEX, -10)
        target:addMod(xi.mod.VIT, -10)
        target:addMod(xi.mod.AGI, -10)
        target:addMod(xi.mod.INT, -10)
        target:addMod(xi.mod.MND, -10)
        target:addMod(xi.mod.CHR, -10)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    if effect:getPower() == 1 then -- Dried Meat
        target:delMod(xi.mod.STR, 4)
        target:delMod(xi.mod.FOOD_ATTP, 22)
        target:delMod(xi.mod.FOOD_ATT_CAP, 63)
    elseif effect:getPower() == 2 then -- Salted Fish
        target:delMod(xi.mod.VIT, 2)
        target:delMod(xi.mod.FOOD_DEFP, 30)
        target:delMod(xi.mod.FOOD_DEF_CAP, 86)
    elseif effect:getPower() == 3 then -- Hard Cookie
        target:delMod(xi.mod.INT, 4)
        target:delMod(xi.mod.MP, 30)
    elseif effect:getPower() == 4 then -- Instant Noodles
        target:delMod(xi.mod.VIT, 1)
        target:delMod(xi.mod.FOOD_HPP, 27)
        target:delMod(xi.mod.FOOD_HP_CAP, 75)
        target:delMod(xi.mod.STORETP, 5)
    elseif effect:getPower() == 5 then -- Dried Agaricus
        target:delMod(xi.mod.MND, 4)
    elseif effect:getPower() == 6 then -- Instant Rice
        target:delMod(xi.mod.CHR, 6)
    elseif effect:getPower() == 255 then -- ACP Seed Goblin Saucepan Attack
        -- Based on info from http://www.bg-wiki.com/bg/Seed_Goblin
        target:delMod(xi.mod.STR, -10)
        target:delMod(xi.mod.DEX, -10)
        target:delMod(xi.mod.VIT, -10)
        target:delMod(xi.mod.AGI, -10)
        target:delMod(xi.mod.INT, -10)
        target:delMod(xi.mod.MND, -10)
        target:delMod(xi.mod.CHR, -10)
    end
end

return effectObject
