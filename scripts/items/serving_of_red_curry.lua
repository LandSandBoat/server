-----------------------------------
-- ID: 4298
-- Item: serving_of_red_curry
-- Food Effect: 3 hours, All Races
-- Group Effects -- https://wiki.ffo.jp/html/4903.html
-----------------------------------
-- HP +25
-- Strength +7
-- Agility +1
-- Intelligence -2
-- HP recovered while healing +2
-- MP recovered while healing +1
-- Attack +23% (Cap: 150@652 Base Attack)
-- Ranged Attack +23% (Cap: 150@652 Base Ranged Attack)
-- Demon Killer +4
-- Resist Sleep +3
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
    [ 1] = { xi.mod.FOOD_HP,        35,  25 },
    [ 2] = { xi.mod.STR,             7,   7 },
    [ 3] = { xi.mod.AGI,             3,   1 },
    [ 4] = { xi.mod.INT,             0,  -2 },
    [ 5] = { xi.mod.HPHEAL,          6,   2 },
    [ 6] = { xi.mod.MPHEAL,          3,   1 },
    [ 7] = { xi.mod.FOOD_ATTP,      25,  23 },
    [ 8] = { xi.mod.FOOD_ATT_CAP,  150, 150 },
    [ 9] = { xi.mod.FOOD_RATTP,     25,  23 },
    [10] = { xi.mod.FOOD_RATT_CAP, 150, 150 },
    [11] = { xi.mod.DEMON_KILLER,    4,   4 },
    [12] = { xi.mod.SLEEPRES,        3,   3 }
}

itemObject.onEffectGain = function(target, effect)
    for i = 1, #dataTable do
        -- Get party factor.
        local partySize = target:getPartySize()
        local column = 3
        if partySize >= 4 then
            column = 2
        end

        effect:addMod(dataTable[i][1], dataTable[i][column])
    end
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
