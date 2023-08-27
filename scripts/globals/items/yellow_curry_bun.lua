-----------------------------------
-- ID: 5757
-- Item: yellow_curry_bun
-- Food Effect: 30minutes, All Races
-----------------------------------
-- TODO: Group effects
-- Health Points 20
-- Strength 5
-- Agility 2
-- Intelligence -4
-- Attack 20% (caps @ 75)
-- Ranged Attack 20% (caps @ 75)
-- Resist Sleep +3
-- Resist Stun +4
-- hHP +2
-- hMP +1
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5757)
end

itemObject.onEffectGain = function(target, effect)
    if target:getPartySize() > 3 then
        target:addMod(xi.mod.HP, 20)
        target:addMod(xi.mod.STR, 5)
        target:addMod(xi.mod.AGI, 2)
        target:addMod(xi.mod.INT, -4)
        target:addMod(xi.mod.FOOD_ATTP, 20)
        target:addMod(xi.mod.FOOD_ATT_CAP, 85)
        target:addMod(xi.mod.FOOD_RATTP, 20)
        target:addMod(xi.mod.FOOD_RATT_CAP, 85)
        target:addMod(xi.mod.SLEEPRESTRAIT, 3)
        target:addMod(xi.mod.STUNRESTRAIT, 4)
        target:addMod(xi.mod.HPHEAL, 2)
        target:addMod(xi.mod.MPHEAL, 1)
    else
        target:addMod(xi.mod.HP, 20)
        target:addMod(xi.mod.STR, 5)
        target:addMod(xi.mod.AGI, 2)
        target:addMod(xi.mod.INT, -4)
        target:addMod(xi.mod.FOOD_ATTP, 20)
        target:addMod(xi.mod.FOOD_ATT_CAP, 75)
        target:addMod(xi.mod.FOOD_RATTP, 20)
        target:addMod(xi.mod.FOOD_RATT_CAP, 75)
        target:addMod(xi.mod.SLEEPRESTRAIT, 3)
        target:addMod(xi.mod.STUNRESTRAIT, 4)
        target:addMod(xi.mod.HPHEAL, 2)
        target:addMod(xi.mod.MPHEAL, 1)
    end
end

itemObject.onEffectLose = function(target, effect)
    if target:getMod(xi.mod.FOOD_ATT_CAP) == 85 then
        target:delMod(xi.mod.HP, 20)
        target:delMod(xi.mod.STR, 5)
        target:delMod(xi.mod.AGI, 2)
        target:delMod(xi.mod.INT, -4)
        target:delMod(xi.mod.FOOD_ATTP, 20)
        target:delMod(xi.mod.FOOD_ATT_CAP, 85)
        target:delMod(xi.mod.FOOD_RATTP, 20)
        target:delMod(xi.mod.FOOD_RATT_CAP, 85)
        target:delMod(xi.mod.SLEEPRESTRAIT, 3)
        target:delMod(xi.mod.STUNRESTRAIT, 4)
        target:delMod(xi.mod.HPHEAL, 2)
        target:delMod(xi.mod.MPHEAL, 1)
    else
        target:delMod(xi.mod.HP, 20)
        target:delMod(xi.mod.STR, 5)
        target:delMod(xi.mod.AGI, 2)
        target:delMod(xi.mod.INT, -4)
        target:delMod(xi.mod.FOOD_ATTP, 20)
        target:delMod(xi.mod.FOOD_ATT_CAP, 75)
        target:delMod(xi.mod.FOOD_RATTP, 20)
        target:delMod(xi.mod.FOOD_RATT_CAP, 75)
        target:delMod(xi.mod.SLEEPRESTRAIT, 3)
        target:delMod(xi.mod.STUNRESTRAIT, 4)
        target:delMod(xi.mod.HPHEAL, 2)
        target:delMod(xi.mod.MPHEAL, 1)
    end
end

return itemObject
