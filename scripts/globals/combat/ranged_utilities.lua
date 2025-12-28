-----------------------------------
-- Handles the ranged attack and accuracy penalties based on distance from target.
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.ranged = xi.combat.ranged or {}
-----------------------------------

xi.combat.ranged.maxInnerPenalty = 25
xi.combat.ranged.maxOuterPenalty = 20

-- This table provides the default sweet spot ranges for various weapon types, agnostic of mob sizes altogether
xi.combat.ranged.sweetSpotDefaults = {
    ['throwing'] = { 0.0, 1.3 },
    ['cannon'  ] = { 3.0, 4.3 }, -- needs re-verification
    ['gun'     ] = { 3.0, 4.3 },
    ['shortbow'] = { 4.0, 6.4 },
    ['crossbow'] = { 5.0, 8.4 },
    ['longbow' ] = { 6.0, 9.5 },
}

-- This table provides the sweet spot ranges for weapons, assuming a mob size of 1
-- TODO: this needs re-verification due to better understanding of hitbox sizes
xi.combat.ranged.sweetSpots = {
    [xi.item.YOICHINOYUMI_75               ] = { 5.5, 9.5 },
    [xi.item.YOICHINOYUMI_80               ] = { 5.5, 9.5 },
    [xi.item.YOICHINOYUMI_85               ] = { 5.5, 9.5 },
    [xi.item.YOICHINOYUMI_90               ] = { 5.5, 9.5 },
    [xi.item.YOICHINOYUMI_95               ] = { 5.5, 9.5 },
    [xi.item.YOICHINOYUMI_99               ] = { 5.5, 9.5 },
    [xi.item.YOICHINOYUMI_99_II            ] = { 5.5, 9.5 },
    [xi.item.YOICHINOYUMI_119              ] = { 5.5, 9.5 },
    [xi.item.YOICHINOYUMI_119_II           ] = { 5.5, 9.5 },
    [xi.item.YOICHINOYUMI_119_III          ] = { 5.5, 9.5 },
    [xi.item.YOICHINOYUMI_119_III_NO_QUIVER] = { 5.5, 9.5 },
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
    local centroidStart = sweetSpotStart + defender:getHitboxSize() + attacker:getHitboxSize()
    local centroidEnd = sweetSpotEnd + defender:getHitboxSize() + attacker:getHitboxSize()
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

    local centroidEnd = sweetSpotEnd + defender:getHitboxSize() + attacker:getHitboxSize()

    if distance <= centroidEnd then
        return 0
    end

    -- Linear interpolation between centroidEnd and 25
    local penaltyPercentage = (distance - centroidEnd) / (25 - centroidEnd)
    local penalty = math.abs(math.floor(penaltyPercentage * (attacker:getMainLvl() / 2)))

    return penalty
end

xi.combat.ranged.shouldUseAmmo = function(attacker)
    if attacker:isPC() then
        local recycleChance = attacker:getMod(xi.mod.RECYCLE) + attacker:getMerit(xi.merit.RECYCLE) + attacker:getJobPointLevel(xi.jp.AMMO_CONSUMPTION)

        if attacker:hasStatusEffect(xi.effect.UNLIMITED_SHOT) then
            attacker:delStatusEffect(xi.effect.UNLIMITED_SHOT) -- TODO: allegedly Unlimited Shot doesn't remove itself unless you hit
            recycleChance = 100
        end

        if math.random(1, 100) <= recycleChance then
            return false
        end

        return true
    end

    return false
end
