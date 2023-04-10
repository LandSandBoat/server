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
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if
        target:hasStatusEffect(xi.effect.FOOD) or
        target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
    then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    local chocoboShirt = target:getEquipID(xi.slot.BODY) == 10293
    target:addStatusEffect(xi.effect.FOOD, chocoboShirt, 0, 300, 4545)
end

itemObject.onEffectGain = function(target, effect)
    local power = effect:getPower()
    if power == 1 then
        target:addMod(xi.mod.AGI, 13)
        target:addMod(xi.mod.VIT, -5)
    else
        target:addMod(xi.mod.AGI, 3)
        target:addMod(xi.mod.VIT, -5)
    end
end

-----------------------------------
-- onEffectLose Action
-----------------------------------
itemObject.onEffectLose = function(target, effect)
    local power = effect:getPower()
    if power == 1 then
        target:delMod(xi.mod.AGI, 13)
        target:delMod(xi.mod.VIT, -5)
    else
        target:delMod(xi.mod.AGI, 3)
        target:delMod(xi.mod.VIT, -5)
    end
end

return itemObject
