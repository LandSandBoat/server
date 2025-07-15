-----------------------------------
-- Handles the ranged attack and accuracy penalties based on distance from target.
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.ranged = xi.combat.ranged or {}
-----------------------------------

xi.combat.ranged.maxInnerPenalty = 25
xi.combat.ranged.maxOuterPenalty = 20

-- This table provides the default sweet spot ranges for various weapon types, assuming a mob size of 1
xi.combat.ranged.sweetSpotDefaults = {
    ['throwing'] = { 0.0, 3.5  },
    ['cannon'  ] = { 5.0, 6.0  },
    ['gun'     ] = { 5.0, 6.0  },
    ['shortbow'] = { 6.0, 8.0  },
    ['crossbow'] = { 7.0, 10.0 },
    ['longbow' ] = { 8.0, 11.0 },
}

-- This table provides the sweet spot ranges for weapons, assuming a mob size of 1
xi.combat.ranged.sweetSpots = {
    [xi.item.YOICHINOYUMI_75               ] = { 7.5, 11 },
    [xi.item.YOICHINOYUMI_80               ] = { 7.5, 11 },
    [xi.item.YOICHINOYUMI_85               ] = { 7.5, 11 },
    [xi.item.YOICHINOYUMI_90               ] = { 7.5, 11 },
    [xi.item.YOICHINOYUMI_95               ] = { 7.5, 11 },
    [xi.item.YOICHINOYUMI_99               ] = { 7.5, 11 },
    [xi.item.YOICHINOYUMI_99_II            ] = { 7.5, 11 },
    [xi.item.YOICHINOYUMI_119              ] = { 7.5, 11 },
    [xi.item.YOICHINOYUMI_119_II           ] = { 7.5, 11 },
    [xi.item.YOICHINOYUMI_119_III          ] = { 7.5, 11 },
    [xi.item.YOICHINOYUMI_119_III_NO_QUIVER] = { 7.5, 11 },
}

xi.combat.ranged.getSweetSpotByAttacker = function(attacker)
    local weapon = attacker:getEquippedItem(xi.slot.RANGED)
    local weaponSkillType = weapon ~= nil and attacker:getWeaponSkillType(xi.slot.RANGED)
    local weaponSubSkillType = weapon ~= nil and attacker:getWeaponSubSkillType(xi.slot.RANGED)

    local weaponId = weapon and weapon:getID() or 0

    local sweetSpotForWeaponId = xi.combat.ranged.sweetSpots[weaponId]
    if sweetSpotForWeaponId ~= nil then
        return sweetSpotForWeaponId
    end

    if weaponSkillType == xi.skill.ARCHERY and weaponSubSkillType == 4 then
        return xi.combat.ranged.sweetSpotDefaults['longbow']
    elseif weaponSkillType == xi.skill.ARCHERY and weaponSubSkillType == 0 then
        return xi.combat.ranged.sweetSpotDefaults['shortbow']
    elseif weaponSkillType == xi.skill.MARKSMANSHIP and weaponSubSkillType == 0 then
        return xi.combat.ranged.sweetSpotDefaults['crossbow']
    elseif weaponSkillType == xi.skill.MARKSMANSHIP and weaponSubSkillType == 1 then
        return xi.combat.ranged.sweetSpotDefaults['gun']
    elseif weaponSkillType == xi.skill.MARKSMANSHIP and weaponSubSkillType == 2 then
        return xi.combat.ranged.sweetSpotDefaults['cannon']
    end

    return xi.combat.ranged.sweetSpotDefaults['throwing']
end

xi.combat.ranged.attackDistancePenalty = function(attacker, defender)
    if not attacker:isPC() then
        return 0
    end

    local sweetSpot = xi.combat.ranged.getSweetSpotByAttacker(attacker)
    local sweetSpotStart = sweetSpot[1]
    local sweetSpotEnd = sweetSpot[2]
    local distance = attacker:checkDistance(defender)
    local centroidStart = sweetSpotStart + defender:getModelSize() + attacker:getModelSize() - 1
    local centroidEnd = sweetSpotEnd + defender:getModelSize() + attacker:getModelSize() - 1
    local cSkillMax = attacker:getMaxSkillLevel(attacker:getMainLvl(), xi.job.WAR, xi.skill.EVASION)

    local penaltyPercentage
    if distance < centroidStart then
        -- Linear interpolation between 0 and centroidStart of maxInnerPenalty
        penaltyPercentage = -xi.combat.ranged.maxInnerPenalty + (xi.combat.ranged.maxInnerPenalty * (distance / centroidStart))
    elseif distance <= centroidEnd then
        -- No penalty in sweet spot
        penaltyPercentage = 0
    else
        -- Linear interpolation between centroidEnd and 25 of maxOuterPenalty
        penaltyPercentage = xi.combat.ranged.maxOuterPenalty * (distance - centroidEnd) / (25 - centroidEnd)
    end

    local penalty = math.abs(math.ceil((penaltyPercentage / 100) * cSkillMax))

    return penalty
end

xi.combat.ranged.accuracyDistancePenalty = function(attacker, defender)
    if not attacker:isPC() then
        return 0
    end

    local sweetSpot = xi.combat.ranged.getSweetSpotByAttacker(attacker)
    local sweetSpotEnd = sweetSpot[2]
    local distance = attacker:checkDistance(defender)

    local centroidEnd = sweetSpotEnd + defender:getModelSize() + attacker:getModelSize() - 1

    if distance <= centroidEnd then
        return 0
    end

    -- Linear interpolation between centroidEnd and 25
    local penaltyPercentage = (distance - centroidEnd) / (25 - centroidEnd)
    local penalty = math.abs(math.floor(penaltyPercentage * (attacker:getMainLvl() / 2)))

    return penalty
end
