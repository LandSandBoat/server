-----------------------------------
-- ID: 4545
-- Item: Bunch of Gysahl Greens
-- Food Effect: 5Min, All Races
-----------------------------------
-- Agility +3
-- Vitality -5
-- Additional Effect with Chocobo Shirt
-- Agility +10
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    local chocoboShirt = target:getMod(xi.mod.APPRECIATE_GYSAHL_GREENS)
    target:addStatusEffect(xi.effect.FOOD, chocoboShirt, 0, 300, 4545)
end

itemObject.onEffectGain = function(target, effect)
    local power = effect:getPower()
    if power == 0 then
        target:addMod(xi.mod.AGI, 3)
        target:addMod(xi.mod.VIT, -5)
    else
        target:addMod(xi.mod.AGI, 13)
        target:addMod(xi.mod.VIT, -5)
    end
end

itemObject.onEffectLose = function(target, effect)
    local power = effect:getPower()
    if power == 0 then
        target:delMod(xi.mod.AGI, 3)
        target:delMod(xi.mod.VIT, -5)
    else
        target:delMod(xi.mod.AGI, 13)
        target:delMod(xi.mod.VIT, -5)
    end
end

return itemObject
