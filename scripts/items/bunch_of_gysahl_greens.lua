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
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    local chocoboShirt = target:getMod(xi.mod.APPRECIATE_GYSAHL_GREENS)
    target:addStatusEffect(xi.effect.FOOD, chocoboShirt, 0, 300, 4545)
end

itemObject.onEffectGain = function(target, effect)
    local power = effect:getPower()
    if power == 0 then
        effect:addMod(xi.mod.AGI, 3)
        effect:addMod(xi.mod.VIT, -5)
    else
        effect:addMod(xi.mod.AGI, 13)
        effect:addMod(xi.mod.VIT, -5)
    end
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
