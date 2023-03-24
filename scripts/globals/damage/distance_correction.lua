-----------------------------------
xi = xi or {}
xi.damage = xi.damage or {}
xi.damage.distanceCorrection = xi.damage.distanceCorrection or {}
-----------------------------------

xi.damage.distanceCorrection.table =
{
    LONGBOW =
    {
        { range =  3.00, base = 0.65, modifier =  1.67 }, -- <=3'
        { range =  5.00, base = 0.65, modifier =  2.60 }, -- <=5.0'
        { range =  7.49, base = 0.65, modifier =  4.66 }, -- <7.5'
        { range = 10.50, base = 1.00, modifier =   nil }, -- Sweet Spot from 7.5' to 10.5'
        { range = 15.00, base = 1.00, modifier = -1.78 }, -- <=15.0'
        { range = 20.00, base = 1.00, modifier = -1.15 }, -- <=20.0'
        { range =   nil, base = 1.00, modifier = -0.90 }, -- Default to >20' Curve w/o Cap
    },

    CROSSBOW =
    {
        { range =  3.00, base = 0.65, modifier =  3.30 }, -- <=3'
        { range =  5.00, base = 0.65, modifier =  4.40 }, -- <=5'
        { range =  5.99, base = 0.65, modifier =  5.83 }, -- <6'
        { range = 10.00, base = 1.00, modifier =   nil }, -- Sweet Spot from 6' to 10'
        { range = 15.00, base = 1.00, modifier = -2.00 }, -- <=15'
        { range = 20.00, base = 1.00, modifier = -1.10 }, -- <=20'
        { range =   nil, base = 0.86, modifier =   nil }, -- Default to >20' Curve w/o Cap
    },

    GUN =
    {
        { range =  3.00, base = 0.75, modifier =  3.33 }, -- <=3'
        { range =  4.49, base = 0.75, modifier =  5.56 }, -- <4.5'
        { range =  5.50, base = 1.00, modifier =   nil }, -- Sweet spot from 4.5' to 5.5'
        { range =  7.50, base = 1.00, modifier = -2.50 }, -- <=7.5'
        { range = 10.00, base = 1.00, modifier = -2.22 }, -- <=10'
        { range = 15.00, base = 1.00, modifier = -1.26 }, -- <=15'
        { range = 20.00, base = 1.00, modifier = -0.96 }, -- <=20'
        { range =   nil, base = 1.00, modifier = -0.67 }, -- Default to >20' Curve w/o Cap
    },
}

xi.damage.distanceCorrection.applyCurve = function(distance, curve)
    for i = 1, #curve do
        if curve[i].modifier == nil then
            return curve[i].base
        end

        if
            distance <= curve[i].range or
            curve[i].range == nil
        then
            return curve[i].base + ((curve[i].modifier * distance) / 100)
        end
    end

    -- Fallback
    return 1.00
end

xi.damage.distanceCorrection.throwing = function(distance)
    if distance <= 1.00 then
        return 1.00 -- Sweet Spot Under or at 1'
    end

    return 1.00 - ((1.00 * distance) / 100) -- Lose 1%/yalm
end

xi.damage.distanceCorrection.automaton = function(distance)
    if distance <= 3.0 then -- Automaton will generally stay around 3' from the target.
        return 1.0
    elseif distance <= 25.0 then -- Beyond 3' linearly drop 1%/yalm
        return 1.0 - (distance / 100.0)
    end

    return 0.75 -- Cap at 0.75 modifier past 25 yalms
end

xi.damage.distanceCorrection.getValue = function(attacker, distance)
    if attacker == nil then
        return 1.00 -- Just in case BattleEntity is null, then we will just return full damage.
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

    local longBowCurve  = (rMainType == xi.skill.ARCHERY) and rMainSub == 9                                       -- Longbows Only
    local crossbowCurve = (rMainType == xi.skill.ARCHERY or rMainType == xi.skill.MARKSMANSHIP) and rMainSub == 0 -- Crossbows and Shortbows
    local gunCurve      = (rMainType == xi.skill.MARKSMANSHIP) and rMainSub == 1                                  -- Guns Only

    if longBowCurve then
        return xi.damage.distanceCorrection.applyCurve(distance, xi.damage.distanceCorrection.table.LONGBOW)

    elseif crossbowCurve then
        return xi.damage.distanceCorrection.applyCurve(distance, xi.damage.distanceCorrection.table.CROSSBOW)

    elseif gunCurve then
        return xi.damage.distanceCorrection.applyCurve(distance, xi.damage.distanceCorrection.table.GUN)

    else -- Default to Throwing Curve
        return xi.damage.distanceCorrection.throwing(distance)
    end
end

return xi.damage.distanceCorrection
