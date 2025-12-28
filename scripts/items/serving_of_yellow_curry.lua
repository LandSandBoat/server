-----------------------------------
-- ID: 4517
-- Item: serving_of_yellow_curry
-- Food Effect: 3hours, All Races
-- https://wiki.ffo.jp/html/5679.html
-----------------------------------
-- Health Points 20
-- Strength 5
-- Agility 2
-- Intelligence -4
-- HP Recovered While Healing 2
-- MP Recovered While Healing 1
-- Attack 21% (caps @ 75)
-- Ranged Attack 21% (caps @ 75)
-- Resist Sleep +3
-- Resist Stun +4
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

local dataTable =
{
    [ 1] = { xi.mod.FOOD_HP,       30, 25, 20 },
    [ 2] = { xi.mod.VIT,            2,  1,  0 },
    [ 3] = { xi.mod.AGI,            3,  3,  2 },
    [ 4] = { xi.mod.INT,           -2, -3, -4 },
    [ 5] = { xi.mod.HPHEAL,         6,  4,  2 },
    [ 6] = { xi.mod.MPHEAL,         3,  2,  1 },
    [ 7] = { xi.mod.FOOD_ATTP,     22, 21, 21 },
    [ 8] = { xi.mod.FOOD_ATT_CAP,  85, 80, 75 },
    [ 9] = { xi.mod.FOOD_RATTP,    22, 21, 21 },
    [10] = { xi.mod.FOOD_RATT_CAP, 85, 80, 75 },
    [11] = { xi.mod.SLEEPRES,       4,  3,  3 },
    [12] = { xi.mod.STUNRES,        5,  4,  4 },
    [13] = { xi.mod.STR,            5,  5,  5 }
}

itemObject.onEffectGain = function(target, effect)
    for i = 1, #dataTable do
        -- Get party factor.
        local partySize = target:getPartySize()
        local column = 4
        if partySize >= 4 then
            column = 2
        elseif partySize >= 2 then
            column = 3
        end

        effect:addMod(dataTable[i][1], dataTable[i][column])
    end
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
