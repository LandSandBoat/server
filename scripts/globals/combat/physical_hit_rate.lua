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

-- https://www.bg-wiki.com/ffxi/Hit_Rate
-- This is only for melee attacks
---@param attacker CBaseEntity
---@param slot xi.attackAnimation
---@return number
xi.combat.physicalHitRate.getPhysicalHitRateCap = function(attacker, slot)
    if attacker:isPet() then
        return 0.99
    elseif attacker:isPC() then
        if attacker:isUsingH2H() then -- Kicks aren't explicitly listed as 99%, TODO: needs verification
            return 0.99
        elseif attacker:isWeaponTwoHanded() or slot >= xi.attackAnimation.LEFT_ATTACK then -- 1h offhand, ranged
            return 0.95
        end

        return 0.99 -- 1h mainhand
    end

    return 0.95 -- mobs, charmed pets. -- Do trusts have a 99% or 95% acc cap?
end

---@param attacker CBaseEntity
---@param target CBaseEntity
---@param isWeaponskill boolean
---@return number, number
xi.combat.physicalHitRate.getHitRateModifiers = function(attacker, target, isWeaponskill, isRanged)
    local accBonus = 0
    local evaBonus = 0

    -- Melee only
    if not isRanged then
        local flourishEffect = attacker:getStatusEffect(xi.effect.BUILDING_FLOURISH)

        if
            isWeaponskill and
            flourishEffect ~= nil and
            flourishEffect:getPower() >= 1
        then -- 1 or more Finishing moves used.
            accBonus = 40 + flourishEffect:getSubPower() * 2
        end

        if
            attacker:hasStatusEffect(xi.effect.INNIN) and
            attacker:isBehind(target, 23) -- angle needs confirmation
        then
            -- Innin acc boost if attacker is behind target
            accBonus = accBonus + attacker:getStatusEffect(xi.effect.INNIN):getPower()
        end

        -- Yonin reduces your accuracy regardless of position
        if attacker:hasStatusEffect(xi.effect.YONIN) then
            accBonus = accBonus - attacker:getStatusEffect(xi.effect.YONIN):getPower()
        end

        if attacker:isPC() and attacker:isFacing(target) then
            accBonus = accBonus + attacker:getMerit(xi.merit.CLOSED_POSITION)
        end
    end

    -- Description calls out both melee and ranged
    if attacker:hasTrait(xi.trait.AMBUSH) and attacker:isBehind(target, 23) then
        accBonus = accBonus + attacker:getMerit(xi.merit.AMBUSH)
    end

    -- Yonin evasion is likely agnostic to ranged or melee but needs confirmation
    if
        attacker:hasStatusEffect(xi.effect.YONIN) and
        attacker:isFacing(target, 64) -- angle needs confirmation
    then
        evaBonus = evaBonus + attacker:getStatusEffect(xi.effect.YONIN):getPower()
    end

    -- target modifiers
    if target:isPC() and target:isFacing(attacker) then
        evaBonus = evaBonus + target:getMerit(xi.merit.CLOSED_POSITION)
    end

    -- TODO: realtime flash penalty

    return accBonus, evaBonus
end

---@param attacker CBaseEntity
---@param target CBaseEntity
---@param acc number
---@param eva number
---@return number
local function accuracyAndEvasionToHitRate(attacker, target, acc, eva)
    local shouldApplyLevelCorrection = xi.data.levelCorrection.isLevelCorrectedZone(attacker)

    if shouldApplyLevelCorrection then
        local dlvl = attacker:getMainLvl() - target:getMainLvl()

        -- cap dlvl for avatars. It's known to cap at 38
        if attacker:isAvatar() then
            dlvl = utils.clamp(dlvl, 0, 38)
        end

        -- Accuracy Bonus, doesn't apply to PCs
        if not attacker:isPC() and attacker:getMainLvl() > target:getMainLvl() then
            acc = acc + dlvl * 4

        -- Accuracy Penalty, only applies to PCs -- TODO: does this apply to player pets?
        elseif attacker:isPC() and attacker:getMainLvl() < target:getMainLvl() then
            acc = acc - dlvl * 4
        end
    end

    local hitdiff = (acc - eva) / 2
    local hitrate = (75 + hitdiff) / 100

    return hitrate
end

---@param attacker CBaseEntity
---@param target CBaseEntity
---@param bonus number
---@param slot xi.attackAnimation
---@param isWeaponskill boolean
---@return number
xi.combat.physicalHitRate.getPhysicalHitRate = function(attacker, target, bonus, slot, isWeaponskill)
    local hitRateCap = xi.combat.physicalHitRate.getPhysicalHitRateCap(attacker, slot)

    local acc = attacker:getACC(slot) -- TODO: clamp slot for 0, 1, 2 (mainhand, offhand, kick)
    local eva = target:getEVA()

    local accBonus, evaBonus = xi.combat.physicalHitRate.getHitRateModifiers(attacker, target, isWeaponskill, false)

    if bonus == nil then
        bonus = 0
    end

    acc = acc + bonus + accBonus
    eva = eva + evaBonus

    local hitrate = accuracyAndEvasionToHitRate(attacker, target, acc, eva)

    -- Apply hitrate caps
    hitrate = utils.clamp(hitrate, 0.2, hitRateCap)

    return hitrate
end

---@param attacker CBaseEntity
---@param target CBaseEntity
---@param bonus number
---@param isWeaponskill boolean
---@return number
xi.combat.physicalHitRate.getRangedHitRate = function(attacker, target, bonus, isWeaponskill)
    local distance = attacker:checkDistance(target)

    -- special case
    if distance > 25 then
        return 0
    end

    local acc = attacker:getRACC()
    local eva = target:getEVA()

    local accBonus, evaBonus = xi.combat.physicalHitRate.getHitRateModifiers(attacker, target, isWeaponskill, true)

    if bonus == nil then
        bonus = 0
    end

    acc = acc + bonus + accBonus - xi.combat.ranged.accuracyDistancePenalty(attacker, target)
    eva = eva + evaBonus

    local hitrate = accuracyAndEvasionToHitRate(attacker, target, acc, eva)

    -- Apply hitrate caps
    hitrate = utils.clamp(hitrate, 0.05, 0.95)

    return hitrate
end
