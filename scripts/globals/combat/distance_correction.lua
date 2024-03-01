-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.distanceCorrection = xi.combat.distanceCorrection or {}
-----------------------------------

-- Distance formulas based on piecewise polynomial curve fitting to values from
-- https://ffxiclopedia.fandom.com/wiki/Distance#Distance_and_Ranged_Attack
xi.combat.distanceCorrection.table =
{
    LONGBOW =
    {
        {
            range =  1,
            func = function(dist)
                return 65  -- <=1'
            end
        },
        {
            range =  7.49,
            func = function(dist)
                return 0.10641 * dist^3 - 0.582692 * dist^2 + 3.44744 * dist + 62.0288 -- <7.5'
            end
        },
        {
            range = 10.50,
            func = function(dist)
                return 100 -- Sweet Spot from 7.5' to 10.5'
            end
        },
        {
            range = 25,
            func = function(dist)
                return -0.0071708 * dist^3 + 0.450248 * dist^2 - 9.72569 * dist + 160.781 -- <=15.0'
            end
        },
        {
            range = 100,
            func = function(dist)
                return 87  -- Default to >25'
            end
        },
    },

    CROSSBOW =
    {
        {
            range =  1,
            func = function(dist)
                return 65  -- <=1'
            end
        },
        {
            range =  5.99,
            func = function(dist)
                return 0.846734 * dist^2 + 0.796482 * dist + 63.7337 -- <6'
            end
        },
        {
            range = 10,
            func = function(dist)
                return 100  -- Sweet Spot from 6' to 10'
            end
        },
        {
            range = 20,
            func = function(dist)
                return 0.12 * dist^2 - 5 * dist + 138 -- <=20'
            end

        },
        {
            range = 100,
            func = function(dist)
                return 86 -- Default for >20'
            end
        },
    },

    GUN =
    {
        {
            range =  1,
            func = function(dist)
                return 75 -- <=1'
            end
        },
        {
            range =  4.49,
            func = function(dist)
                return 1.42857 * dist^2 - 0.714286 * dist + 74.2857  -- <4.5'
            end
        },
        {
            range =  6,
            func = function(dist) -- Sweet spot from 4.5' to 6.0'
                return 100
            end
        },
        {
            range = 15,
            func = function(dist)
                return -0.0133333 * dist^3 + 0.646667 * dist^2 - 10.2333 * dist + 141 -- <=15'
            end
        },
        {
            range = 25,
            func = function(dist)
                return dist^2 / 50 - (11 * dist) / 10 + 100  -- <=20'
            end
        },
        {
            range = 100,
            func = function(dist)
                return 85  -- Default for >20'
            end
        },
    },
}

xi.combat.distanceCorrection.applyCurve = function(distance, curve)
    for i = 1, #curve do
        if distance <= curve[i].range then
            -- the curve table is out of 100 thus clamp and divide to get [0,1]
            return utils.clamp(curve[i].func(distance), 65, 100) / 100
        end
    end

    -- Fallback
    return 1
end

xi.combat.distanceCorrection.throwing = function(distance)
    if distance <= 1 then
        return 1 -- Sweet Spot Under or at 1'
    end

    return 1 - distance / 100 -- Lose 1%/yalm
end

xi.combat.distanceCorrection.automaton = function(distance)
    if distance <= 3 then -- Automaton will generally stay around 3' from the target.
        return 1
    elseif distance <= 25 then -- Beyond 3' linearly drop 1%/yalm
        return 1 - distance / 100
    end

    return 0.75 -- Cap at 0.75 modifier past 25 yalms
end

xi.combat.distanceCorrection.getValue = function(attacker, distance)
    if attacker == nil then
        return 1 -- Just in case BattleEntity is null, then we will just return full damage.
    end

    -- Automaton
    if not attacker:isPC() then
        return xi.damage.distanceCorrection.automaton(distance)
    end

    local rMainType = 0
    local rMainSub = 0

    if attacker:getEquipID(xi.slot.RANGED) > 0 then
        rMainType = attacker:getWeaponSkillType(xi.slot.RANGED)
        rMainSub  = attacker:getWeaponSubSkillType(xi.slot.RANGED)
    end

    local longBowCurve  = (rMainType == xi.skill.ARCHERY) and rMainSub == xi.subskill.LONGBOW -- Longbows Only
    local crossbowCurve = (rMainType == xi.skill.ARCHERY or rMainType == xi.skill.MARKSMANSHIP) and rMainSub == xi.subskill.XBOW_SHORTBOW -- Crossbows and Shortbows
    local gunCurve      = (rMainType == xi.skill.MARKSMANSHIP) and rMainSub == xi.subskill.GUN -- Guns Only

    if longBowCurve then
        return xi.combat.distanceCorrection.applyCurve(distance, xi.combat.distanceCorrection.table.LONGBOW)
    elseif crossbowCurve then
        return xi.combat.distanceCorrection.applyCurve(distance, xi.combat.distanceCorrection.table.CROSSBOW)
    elseif gunCurve then
        return xi.combat.distanceCorrection.applyCurve(distance, xi.combat.distanceCorrection.table.GUN)
    else -- Default to Throwing Curve
        return xi.combat.distanceCorrection.throwing(distance)
    end
end

return xi.combat.distanceCorrection
