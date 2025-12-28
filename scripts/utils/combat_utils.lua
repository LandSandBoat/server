---@class utils
utils = utils or {}

-- A mechanic that will occasionaly reduce shadows consumed by 1 when hit by an AOE skill.
---@nodiscard
---@param actor CBaseEntity
---@param shadowsToRemove integer
---@return integer
function utils.attemptShadowMitigation(actor, shadowsToRemove)
    -- TODO: Currently unknown what conditions/skills/stats might affect proc rate. Ninjutsu, AGI, EVA skills might come to mind.
    -- TODO: Does this work with Blink or only Copy Images?
    -- TODO: Do mobs utilize this mechanic for their shadows?
    -- Note: This seems to work with NIN subjob as well.

    local procChance = 60

    if
        (actor:getMainJob() == xi.job.NIN or actor:getSubJob() == xi.job.NIN) and
        math.random(1, 100) <= procChance
    then
        shadowsToRemove = math.max(1, shadowsToRemove - 1)
    end

    return shadowsToRemove
end

-- Calculate shadow consumption/damage absorbtion.
---@param actor CBaseEntity
---@param damage integer
---@param shadowsToRemove integer?
---@return integer
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
        return damage
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
            damage = 0

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
            damage = damage * ((shadowsToRemove - shadowPower) / shadowsToRemove)
            shadowsRemaining = 0
        end
    end

    actor:setMod(shadowType, shadowsRemaining)

    if shadowsRemaining <= 0 then
        actor:delStatusEffect(xi.effect.COPY_IMAGE)
        actor:delStatusEffect(xi.effect.BLINK)
    end

    return damage
end

-- Calculates Phalanx damage reduction.
---@nodiscard
---@param actor CBaseEntity
---@param damage integer
---@return integer
function utils.handlePhalanx(actor, damage)
    if damage > 0 then
        damage = utils.clamp(damage - actor:getMod(xi.mod.PHALANX), 0, 99999)
    end

    return damage
end

-- Returns reduced magic damage from RUN buff, 'One for All'
---@nodiscard
---@param actor CBaseEntity
---@param damage integer
---@return integer
function utils.handleOneForAll(actor, damage)
    if damage > 0 then
        local oneForAllEffect = actor:getStatusEffect(xi.effect.ONE_FOR_ALL)

        if oneForAllEffect ~= nil then
            local power = oneForAllEffect:getPower()

            damage = utils.clamp(damage - power, 0, 99999)
        end
    end

    return damage
end

-- Calculates Stoneskin damage reduction.
---@nodiscard
---@param actor CBaseEntity
---@param damage integer
---@return integer
function utils.handleStoneskin(actor, damage)
    if damage > 0 then
        local stoneskinRemaining = actor:getMod(xi.mod.STONESKIN)

        if stoneskinRemaining > 0 then
            if stoneskinRemaining > damage then -- Absorb all damage
                actor:delMod(xi.mod.STONESKIN, damage)

                return 0
            else -- Wear off if mitigated damage exceeds stoneskin.
                actor:delStatusEffect(xi.effect.STONESKIN)
                actor:setMod(xi.mod.STONESKIN, 0)

                return damage - stoneskinRemaining
            end
        end
    end

    return damage
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
