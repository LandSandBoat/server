-----------------------------------
-- ID: 5757
-- Item: yellow_curry_bun
-- Food Effect: 30minutes, All Races
-- https://wiki.ffo.jp/html/17703.html
-----------------------------------
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
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

local dataTable =
{
    [ 1] = { xi.mod.FOOD_HP,       30, 25, 20 },
    [ 2] = { xi.mod.VIT,            2,  1,  0 },
    [ 3] = { xi.mod.AGI,            3,  3,  2 },
    [ 4] = { xi.mod.INT,           -2, -3, -4 },
    [ 5] = { xi.mod.FOOD_ATTP,     22, 21, 20 },
    [ 6] = { xi.mod.FOOD_ATT_CAP,  85, 80, 75 },
    [ 7] = { xi.mod.FOOD_RATTP,    22, 21, 20 },
    [ 8] = { xi.mod.FOOD_RATT_CAP, 85, 80, 75 },
    [ 9] = { xi.mod.SLEEPRES,       5,  3,  3 },
    [10] = { xi.mod.STUNRES,        6,  4,  4 },
    [11] = { xi.mod.HPHEAL,         6,  4,  2 },
    [12] = { xi.mod.MPHEAL,         3,  2,  1 },
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
