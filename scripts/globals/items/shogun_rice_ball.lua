-----------------------------------
-- ID: 4278
-- Item: Shogun Rice Ball
-- Food Effect: 60Min, All Races
-----------------------------------
-- HP +20
-- Dex +4
-- Vit +4
-- Chr +4
-- Effect with enhancing equipment (Note: these are latents on gear with the effect)
-- Atk +50
-- Def +30
-- Double Attack +5%
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 4278)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 20)
    target:addMod(xi.mod.DEX, 4)
    target:addMod(xi.mod.VIT, 4)
    target:addMod(xi.mod.CHR, 4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 20)
    target:delMod(xi.mod.DEX, 4)
    target:delMod(xi.mod.VIT, 4)
    target:delMod(xi.mod.CHR, 4)
end

return itemObject
