---@class utils
utils = utils or {}

-- A mechanic that will occasionaly reduce shadows consumed when hit by an AOE skill.
---@nodiscard
---@param actor CBaseEntity
---@param attemptedRemovals integer
---@return integer
function utils.attemptShadowMitigation(actor, attemptedRemovals)
    if attemptedRemovals <= 0 then
        return 0
    end

    -- TODO: Does this mechanic work on players who are not NIN main or sub? If so remove NIN requirement.
    -- See Yagyu Darkblade: https://www.bg-wiki.com/ffxi/Yagyu_Darkblade
    local isNIN       = actor:getMainJob() == xi.job.NIN or actor:getSubJob() == xi.job.NIN
    local hasUtsusemi = actor:getMod(xi.mod.UTSUSEMI) > 0

    if
        not isNIN or
        not hasUtsusemi -- Only works with Utsusemi
    then
        return 0
    end

    -- TODO: Currently unknown exactly what stats affect procChance and by how much. SE mentions Ninjutsu Skill affects this to some degree.
    -- Note: 50% was calculated from data with a relatively low Ninjutsu skill (Between 50-110~ skill range vs Lv. 75+ Targets) so this will likely lean on the conservative side (Weighted against players).
    local procChance = 50

    local mitigated  = 0

    -- Through research, a skill's shadowBehavior acts as a counter for how many shadow mitigation attempts are made(attemptedRemovals).
    -- Example: An AoE skill that takes 4 shadows will attempt the mitgation step below 4 times. A shadow will only be mitigated if it passes the proc chance check.
    for i = 1, attemptedRemovals do
        if math.random(1, 100) <= procChance then
            mitigated = mitigated + 1
        end
    end

    local maxMitigatable = attemptedRemovals - 1

    return math.min(mitigated, maxMitigatable)
end

-- TODO: Marked for retirement. See: utils.shadowAbsorb() below.
--       Some abilities and skills still use this but will need to be slightly reworked to use utils.shadowAbsorb().
-- Calculate shadow consumption/damage absorbtion.
---@param actor CBaseEntity
---@param damage integer
---@param shadowsToRemove integer?
---@return integer damage
---@return integer shadowsUsed
function utils.takeShadows(actor, damage, shadowsToRemove)
    shadowsToRemove = shadowsToRemove or 1

    -- Check for Utsusemi first, then Blink.
    local shadowPower = actor:getMod(xi.mod.UTSUSEMI)
    local shadowType  = xi.mod.UTSUSEMI

    if shadowPower == 0 then
        shadowPower = actor:getMod(xi.mod.BLINK)
        shadowType  = xi.mod.BLINK
    end

    -- No shadows, return full damage
    if shadowPower == 0 then
        return damage, 0
    end

    local shadowsRemaining = shadowPower
    local shadowsUsed      = 0

    -- Handle Blink shadow removal
    if shadowType == xi.mod.BLINK then
        for _ = 1, shadowsToRemove do
            if shadowsRemaining > 0 and math.random(1, 100) <= 80 then
                shadowsRemaining = shadowsRemaining - 1
                shadowsUsed      = shadowsUsed + 1
            end
        end

        if shadowsUsed >= shadowsToRemove then
            damage = 0
        else
            damage = damage * ((shadowsToRemove - shadowsUsed) / shadowsToRemove)
        end
    else
        -- Handle Utsusemi removal
        if shadowPower >= shadowsToRemove then
            shadowsRemaining = shadowPower - shadowsToRemove
            shadowsUsed      = shadowsToRemove
            damage           = 0

            -- Update remaining Copy Image icon
            if shadowsRemaining > 0 then
                local effect = actor:getStatusEffect(xi.effect.COPY_IMAGE)
                if effect then
                    local iconMap =
                    {
                        [1] = xi.effect.COPY_IMAGE,
                        [2] = xi.effect.COPY_IMAGE_2,
                        [3] = xi.effect.COPY_IMAGE_3,
                        -- Note: 4+ use the same icon.
                    }

                    effect:setIcon(iconMap[shadowsRemaining] or xi.effect.COPY_IMAGE_4)
                end
            end
        else
            -- Partial shadow consumption, take damage.
            shadowsUsed      = shadowPower
            damage           = damage * ((shadowsToRemove - shadowPower) / shadowsToRemove)
            shadowsRemaining = 0
        end
    end

    actor:setMod(shadowType, shadowsRemaining)

    if shadowsRemaining <= 0 then
        actor:delStatusEffect(xi.effect.COPY_IMAGE)
        actor:delStatusEffect(xi.effect.BLINK)
    end

    return damage, shadowsUsed
end

-- Calculate shadow consumption
---@param target CBaseEntity
---@param shadowsToRemove number
---@return boolean, number
function utils.shadowAbsorb(target, shadowsToRemove)
    local shadowType    = xi.mod.UTSUSEMI
    local targetShadows = target:getMod(xi.mod.UTSUSEMI)

    if targetShadows == 0 then
        if
            target:getMod(xi.mod.BLINK) == 0 or
            math.random(1, 100) > 80
        then
            return false, 0
        end

        shadowType    = xi.mod.BLINK
        targetShadows = target:getMod(xi.mod.BLINK)
    end

    local actualConsumed   = math.min(targetShadows, shadowsToRemove)
    local hadEnoughShadows = targetShadows >= shadowsToRemove

    targetShadows = targetShadows - actualConsumed

    if shadowType == xi.mod.UTSUSEMI then
        local effect = target:getStatusEffect(xi.effect.COPY_IMAGE)

        if effect then
            local icons = { xi.effect.COPY_IMAGE, xi.effect.COPY_IMAGE_2, xi.effect.COPY_IMAGE_3 }

            if icons[targetShadows] then
                effect:setIcon(icons[targetShadows])
            end
        end
    end

    target:setMod(shadowType, targetShadows)

    if targetShadows == 0 then
        target:delStatusEffect(xi.effect.COPY_IMAGE)
        target:delStatusEffect(xi.effect.BLINK)
    end

    return hadEnoughShadows, actualConsumed
end

-- Calculates Phalanx damage reduction.
---@nodiscard
---@param actor CBaseEntity
---@param damage integer
---@return integer
function utils.handlePhalanx(actor, damage)
    if damage <= 0 then
        return damage
    end

    return utils.clamp(damage - actor:getMod(xi.mod.PHALANX), 0, 99999)
end

-- Returns reduced magic damage from RUN buff, 'One for All'
---@nodiscard
---@param actor CBaseEntity
---@param damage integer
---@return integer
function utils.handleOneForAll(actor, damage)
    if damage <= 0 then
        return damage
    end

    local oneForAllEffect = actor:getStatusEffect(xi.effect.ONE_FOR_ALL)
    if not oneForAllEffect then
        return damage
    end

    return utils.clamp(damage - oneForAllEffect:getPower(), 0, 99999)
end

-- Calculates Stoneskin damage reduction.
---@nodiscard
---@param actor CBaseEntity
---@param damage integer
---@return integer
function utils.handleStoneskin(actor, damage)
    if damage <= 0 then
        return damage
    end

    local stoneskinRemaining = actor:getMod(xi.mod.STONESKIN)
    if stoneskinRemaining <= 0 then
        return damage
    end

    -- Absorb all damage
    if stoneskinRemaining > damage then
        actor:delMod(xi.mod.STONESKIN, damage)

        return 0

    -- Wear off if mitigated damage exceeds stoneskin.
    else
        actor:delStatusEffect(xi.effect.STONESKIN)
        actor:setMod(xi.mod.STONESKIN, 0)

        return damage - stoneskinRemaining
    end
end

-- Handles Automaton attachment "Analyzer" which decreases damage from successive special attacks.
function utils.handleAutomatonAutoAnalyzer(actor, skill, damage)
    local analyzerMod = actor:getMod(xi.mod.AUTO_ANALYZER)

    if analyzerMod > 0 then
        local skillID         = skill:getID()
        local previousSkillID = actor:getLocalVar('analyzer_skillID')
        local analyzerHits    = actor:getLocalVar('analyzer_hits') or 0

        if previousSkillID == skillID and analyzerHits < analyzerMod then
            -- Analyzer reduces damage by 40%
            damage       = math.floor(damage * 0.6)
            analyzerHits = analyzerHits + 1
        else
            -- New skill or exceeded limit
            actor:setLocalVar('analyzer_skillID', skillID)
            analyzerHits = 0
        end

        actor:setLocalVar('analyzer_hits', analyzerHits)
    end

    return damage
end
