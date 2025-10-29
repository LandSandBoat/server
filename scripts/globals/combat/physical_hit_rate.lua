-----------------------------------
-- Global, independent functions for physical hit rate calculations.
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.physicalHitRate = xi.combat.physicalHitRate or {}
-----------------------------------

xi.combat.physicalHitRate.checkAnticipated = function(attacker, defender)
    -- Early Return: Defender lacks Third Eye.
    if not defender:hasStatusEffect(xi.effect.THIRD_EYE) then
        return false
    end

    -- Calculate chance to retain "Third Eye".
    local thirdEyeRetentionChance = 0
    local canRetainThirdEye = not defender:isPC() or defender:isPC() and defender:isWeaponTwoHanded()

    if defender:hasStatusEffect(xi.effect.SEIGAN) and canRetainThirdEye then
        -- Duration left.
        local thirdEyeEffect = defender:getStatusEffect(xi.effect.THIRD_EYE)
        local timeInEffect   = thirdEyeEffect:getDuration() - thirdEyeEffect:getTimeRemaining()

        -- Retention
        local retentionLossPerMillisecond = 1 / 300 -- Retain 100% / 30 seconds (30000 milliseconds)
        local retentionModifier           = utils.clamp(1 - defender:getMod(xi.mod.THIRD_EYE_RETENTION_RATE) / 100, 0, 1) -- 50 = 0.5x reduction in loss per millisecond

        -- Add in retention bonus, Kogarasumaru has a 50% reduction per JP wiki -- https://wiki.ffo.jp/html/15175.html
        -- Other sources such as BG indicate it has a reduction -- https://www.bluegartr.com/threads/71538-Mythic-Weapon-Compiled-Information?p=2972086&highlight=#post2972086

        -- Increase scale by 100x to give more precision to the RNG
        thirdEyeRetentionChance = utils.clamp(100 - timeInEffect * retentionLossPerMillisecond * retentionModifier, 0, 100) * 100
    end

    -- Calculate if "Third Eye" is retained.
    if
        thirdEyeRetentionChance == 0 or
        math.random(1, 10000) > thirdEyeRetentionChance
    then
        defender:delStatusEffect(xi.effect.THIRD_EYE)
    end

    return true
end

xi.combat.physicalHitRate.getPhysicalHitRate = function(attacker, target, bonus, slot, isWeaponskill)
    local flourishEffect = attacker:getStatusEffect(xi.effect.BUILDING_FLOURISH)

    if
        isWeaponskill and
        flourishEffect ~= nil and
        flourishEffect:getPower() >= 1
    then -- 1 or more Finishing moves used.
        attacker:addMod(xi.mod.ACC, 40 + flourishEffect:getSubPower() * 2)
    end

    -- TODO: check mainhand vs offhand
    -- TODO: realtime flash penalty
    local acc = attacker:getACC()
    local eva = target:getEVA()

    if
        isWeaponskill and
        flourishEffect ~= nil and
        flourishEffect:getPower() >= 1
    then -- 1 or more Finishing moves used.
        attacker:delMod(xi.mod.ACC, 40 + flourishEffect:getSubPower() * 2)
    end

    if bonus == nil then
        bonus = 0
    end

    if
        attacker:hasStatusEffect(xi.effect.INNIN) and
        attacker:isBehind(target, 23)
    then
        -- Innin acc boost if attacker is behind target
        bonus = bonus + attacker:getStatusEffect(xi.effect.INNIN):getPower()
    end

    if
        target:hasStatusEffect(xi.effect.YONIN) and
        attacker:isFacing(target, 23)
    then
        -- Yonin evasion boost if attacker is facing target
        bonus = bonus - target:getStatusEffect(xi.effect.YONIN):getPower()
    end

    if attacker:hasTrait(xi.trait.AMBUSH) and attacker:isBehind(target, 23) then
        bonus = bonus + attacker:getMerit(xi.merit.AMBUSH)
    end

    acc = acc + bonus

    -- Accuracy Bonus, doesn't apply to PCs
    if not attacker:isPC() and attacker:getMainLvl() > target:getMainLvl() then
        acc = acc + (attacker:getMainLvl() - target:getMainLvl()) * 4

    -- Accuracy Penalty, only applies to PCs -- TODO: does this apply to player pets?
    elseif attacker:isPC() and attacker:getMainLvl() < target:getMainLvl() then
        acc = acc - (target:getMainLvl() - attacker:getMainLvl()) * 4
    end

    local hitdiff = (acc - eva) / 2
    local hitrate = (75 + hitdiff) / 100

    -- Applying hitrate caps
    -- TODO: per weapon caps
    hitrate = utils.clamp(hitrate, 0.2, 0.95)

    return hitrate
end
