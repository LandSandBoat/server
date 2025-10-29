-----------------------------------
-- Global, independent functions for counter calculations.
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.counter = xi.combat.counter or {}
-----------------------------------

xi.combat.counter.checkSeiganCounter = function(attacker, defender)
    -- Early return: Defender lacks Third Eye.
    if not defender:hasStatusEffect(xi.effect.THIRD_EYE) then
        return false
    end

    -- Early return: Defender lacks Seigan.
    if not defender:hasStatusEffect(xi.effect.SEIGAN) then
        return false
    end

    if not defender:isFacing(attacker, 64) then
        return false
    end

    if not defender:isEngaged() then
        return false
    end

    -- Early return: Defender is a player without the proper weapon type.
    if defender:isPC() and not defender:isWeaponTwoHanded() then
        return false
    end

    -- Calculate counter chance.
    local baseCounterRate = 25 + defender:getMod(xi.mod.THIRD_EYE_COUNTER_RATE)
    local hitRateFactor   = xi.combat.physicalHitRate.getPhysicalHitRate(defender, attacker, 0, 0, false)

    if math.random(1, 100) > baseCounterRate * hitRateFactor then
        return false
    end

    return true
end
