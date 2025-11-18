-----------------------------------
-- ID: 5759
-- Item: red_curry_bun
-- Food Effect: 30 Min, All Races
-- https://wiki.ffo.jp/html/17770.html
-----------------------------------
-- Health 25
-- Strength 7
-- Agility 1
-- Intelligence -2
-- Attack % 23 (cap 150)
-- Ranged Atk % 23 (cap 150)
-- Demon Killer 4
-- Resist Sleep +3
-- HP recovered when healing +2
-- MP recovered when healing +1
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
    [ 1] = { xi.mod.FOOD_HP,        35,  30,  25 },
    [ 2] = { xi.mod.STR,             7,   7,   7 },
    [ 3] = { xi.mod.AGI,             3,   2,   1 },
    [ 4] = { xi.mod.INT,             0,  -1,  -2 },
    [ 5] = { xi.mod.HPHEAL,          6,   4,   2 },
    [ 6] = { xi.mod.MPHEAL,          3,   2,   1 },
    [ 7] = { xi.mod.FOOD_ATTP,      25,  24,  23 },
    [ 8] = { xi.mod.FOOD_ATT_CAP,  150, 150, 150 },
    [ 9] = { xi.mod.FOOD_RATTP,     25,  24,  23 },
    [10] = { xi.mod.FOOD_RATT_CAP, 150, 150, 150 },
    [11] = { xi.mod.DEMON_KILLER,    5,   4,   4 },
    [12] = { xi.mod.SLEEPRES,        5,   3,   3 }
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
