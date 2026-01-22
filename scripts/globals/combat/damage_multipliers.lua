-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.damage = xi.combat.damage or {}
-----------------------------------

xi.combat.damage.physicalElementSDT = function(target, physicalElement)
    if
        physicalElement < xi.damageType.PIERCING or
        physicalElement > xi.damageType.HTH
    then
        return 1
    end

    local physicalElementSDTModifier =
    {
        [xi.damageType.PIERCING] = xi.mod.PIERCE_SDT,
        [xi.damageType.SLASHING] = xi.mod.SLASH_SDT,
        [xi.damageType.BLUNT   ] = xi.mod.IMPACT_SDT,
        [xi.damageType.HTH     ] = xi.mod.HTH_SDT,
    }

    local sdt = 1 + target:getMod(physicalElementSDTModifier[physicalElement]) / 10000

    return utils.clamp(sdt, 0, 3)
end

xi.combat.damage.magicalElementSDT = function(target, magicalElement)
    if
        magicalElement < xi.element.FIRE or
        magicalElement > xi.element.DARK
    then
        return 1
    end

    local sdt = 1 + target:getMod(xi.data.element.getElementalSDTModifier(magicalElement)) / 10000

    return utils.clamp(sdt, 0, 3)
end

xi.combat.damage.calculateDamageAdjustment = function(target, isPhysical, isMagical, isRanged, isBreath)
    -- NOTE: -2500 -> 25% less damage taken by target. 2500 -> 25% more damage taken  by target.
    local targetDamageTaken = 1

    -- "Damage Taken -x%"
    local globalDamageTaken           = target:getMod(xi.mod.DMG) / 10000

    -- "Physical Damage Taken -X%", "Physical Damage Taken II -X%"
    local physicalDamageTaken         = isPhysical and target:getMod(xi.mod.DMGPHYS) / 10000 or 0
    local physicalDamageTakenII       = isPhysical and target:getMod(xi.mod.DMGPHYS_II) / 10000 or 0
    local physicalDamageTakenUncapped = isPhysical and target:getMod(xi.mod.UDMGPHYS) / 10000 or 0

    -- "Magic Damage Taken -X%", "Magic Damage Taken II -X%"
    local magicDamageTaken            = isMagical and target:getMod(xi.mod.DMGMAGIC) / 10000 or 0
    local magicDamageTakenII          = isMagical and target:getMod(xi.mod.DMGMAGIC_II) / 10000 or 0
    local magicDamageTakenUncapped    = isMagical and target:getMod(xi.mod.UDMGMAGIC) / 10000 or 0

    -- "Ranged Damage Taken -X%" (Doesn't actually exist in gear. Physical damage taken has both.)
    local rangedDamageTaken           = isRanged and target:getMod(xi.mod.DMGRANGE) / 10000 or 0
    local rangedDamageTakenUncapped   = isRanged and target:getMod(xi.mod.UDMGRANGE) / 10000 or 0

    -- "Breath Damage Taken -X%"
    local breathDamageTaken           = isBreath and target:getMod(xi.mod.DMGBREATH) / 10000 or 0
    local breathDamageTakenUncapped   = isBreath and target:getMod(xi.mod.UDMGBREATH) / 10000 or 0

     -- The combination of regular "Damage Taken" and "<type> Damage Taken" caps at 50% both ways.
    local combinedDamageTaken = utils.clamp(globalDamageTaken + physicalDamageTaken + magicDamageTaken + rangedDamageTaken + breathDamageTaken, -0.5, 0.5)

    -- "<type> Damage Taken II" bypasses the regular cap, but combined cap is 87.5% both ways.
    targetDamageTaken = utils.clamp(targetDamageTaken + combinedDamageTaken + physicalDamageTakenII + magicDamageTakenII, 0.125, 1.875)

     -- Uncapped damage modifiers. Cap is 100% both ways anyway, just in case.
    targetDamageTaken = utils.clamp(targetDamageTaken + physicalDamageTakenUncapped + magicDamageTakenUncapped + rangedDamageTakenUncapped + breathDamageTakenUncapped, 0, 2)

    return targetDamageTaken
end

xi.combat.damage.scarletDeliriumMultiplier = function(actor)
    -- Scarlet delirium are 2 different status effects. SCARLET_DELIRIUM_1 is the one that boosts power.
    if not actor:hasStatusEffect(xi.effect.SCARLET_DELIRIUM_1) then
        return 1
    end

    local scarletDeliriumMultiplier = 1 + actor:getStatusEffect(xi.effect.SCARLET_DELIRIUM_1):getPower() / 1000

    return scarletDeliriumMultiplier
end
