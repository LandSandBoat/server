-----------------------------------
-- ID: 4277
-- Item: Tonosama Rice Ball
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP +15
-- Dex +3
-- Vit +3
-- Chr +3
-- Effect with enhancing equipment (Note: these are latents on gear with the effect)
-- Atk +50
-- Def +30
-- Double Attack +1%
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 4277)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 15)
    target:addMod(xi.mod.DEX, 3)
    target:addMod(xi.mod.VIT, 3)
    target:addMod(xi.mod.CHR, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 15)
    target:delMod(xi.mod.DEX, 3)
    target:delMod(xi.mod.VIT, 3)
    target:delMod(xi.mod.CHR, 3)
end

return itemObject
