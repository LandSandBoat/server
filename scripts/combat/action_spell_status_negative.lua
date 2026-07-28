-----------------------------------
-- Global file for spells that apply negative status effects
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.action = xi.combat.action or {}
-----------------------------------

-- Disable cyclomatic complexity check for this function:
-- luacheck: ignore 561
local function validateParameters(actor, target, fedData)
    local params = {}

    -- Status effect application parameters.
    params.effectId        = fedData.effectId or xi.effect.NONE
    params.power           = fedData.power or 0
    params.tick            = fedData.tick or 0
    params.duration        = fedData.duration or 120
    params.subType         = fedData.subType or 0
    params.subPower        = fedData.subPower or 0
    params.tier            = fedData.tier or 0
    params.resistRate      = fedData.resistRate or 0

    -- Status effect power and duration options.
    params.powerBonus      = fedData.powerBonus or 0     -- Addition applied last, afer multipliers.
    params.durationBonus   = fedData.durationBonus or 0  -- Addition applied last, afer multipliers.
    params.powerMax        = fedData.powerMax or 99999   -- Final cap.
    params.durationMax     = fedData.durationMax or 3600 -- Final cap.

    -- Action general properties.
    params.magicalElement  = fedData.magicalElement or xi.data.statusEffect.getAssociatedElement(params.effectId, xi.element.NONE)
    params.actorStat       = fedData.actorStat or 0
    params.targetStat      = fedData.targetStat or params.actorStat
    params.skillType       = fedData.skillType or 0
    params.spellGroup      = fedData.spellGroup or 0
    params.ecosystem       = fedData.ecosystem or 0 -- Currently unused. Not enough info about if it affects anything.
    params.bonusMacc       = fedData.bonusMacc or 0

    -- Song specific property.
    params.songPlus        = fedData.songPlus or 0

    -- Action magic burst.
    local canMB            = params.skillType ~= xi.skill.BLUE_MAGIC or actor:hasStatusEffect(xi.effect.AZURE_LORE) or actor:hasStatusEffect(xi.effect.BURST_AFFINITY)
    params.magicBurstTier  = canMB and xi.combat.magicBurst.getMagicBurstTier(target, params.magicalElement) or 0 -- Calculate magic burst.

    -- Action steps effect requirements.
    params.isConal         = fedData.isConal or false        -- Action requires target position.
    params.isGaze          = fedData.isGaze or false         -- Action requires target rotation.
    params.stymie          = fedData.stymie or false         -- Effect affected by Stymie.
    params.fealty          = fedData.fealty or false         -- Effect nullified by Fealty.
    params.soulVoicePower  = fedData.soulVoicePower or false -- Effect power affected by Soul Voice or Marcato.
    params.saboteur        = fedData.saboteur or false       -- Effect power and duration affected by Saboteur.
    params.soulVoiceMacc   = fedData.soulVoiceMacc or false  -- Effect macc affected by Soul Voice or Marcato.

    -- Animations and messaging.
    params.message         = fedData.message or xi.msg.basic.MAGIC_ENFEEB_IS
    params.messageBurst    = fedData.messageBurst or xi.msg.basic.MAGIC_BURST_ENFEEB_IS

    return params
end

local function executeImmunobreak(actor, target, spell, params)
    -- Early return: Immunobreak didn't exist in lvl 75 era.
    if not xi.settings.main.ENABLE_IMMUNOBREAK then
        return
    end

    -- Early return: Only players can immunobreak. (NOTE: Any job can proc Immunobreaks.)
    if not actor:isPC() then
        return
    end

    -- Early return: Only non-players can be immunobroken.
    if not target:isMob() then
        return
    end

    -- Early return: Only Enfeebling magic can immunobreak.
    if params.skillType ~= xi.skill.ENFEEBLING_MAGIC then
        return
    end

    -- Early return: This effect doesn't have an immunobreak associated modifier.
    local immunobreakModId = xi.data.statusEffect.getAssociatedImmunobreakModifier(params.effectId)
    if immunobreakModId == 0 then
        return
    end

    -- Fetch resistance rank modifier (Either effect-specific or elemental)
    local resistanceRankModId = xi.data.statusEffect.getAssociatedResistanceRankModifier(params.effectId, params.magicalElement)
    if resistanceRankModId == 0 then -- If it's an effect and this is 0, try with element.
        resistanceRankModId = xi.data.element.getElementalResistanceRankModifier(params.magicalElement)
    end

    -- Early return: Only mobs with a resistance rank of 6+ (x <= 30% EEM) can be immunobroken.
    local baseResistanceRank  = target:getMod(resistanceRankModId)
    if baseResistanceRank < 6 then
        return
    end

    -- Early return: Resistance rank cannot be lowered (and wont trigger) bellow rank 4 (50% EEM)
    local immunobreakValue    = target:getMod(immunobreakModId)
    local finalResistanceRank = baseResistanceRank - immunobreakValue
    if finalResistanceRank <= 4 then
        return
    end

    -- Calculate Immunobreack chance.
    local saboteurBonus      = (params.saboteur and actor:hasStatusEffect(xi.effect.SABOTEUR)) and 2 or 1
    local immunobreakChance  = (20 + actor:getMerit(xi.merit.IMMUNOBREAK_CHANCE)) * saboteurBonus
    local immunobreakPenalty = 1 + immunobreakValue
    if math.randomInt(1, 100) > immunobreakChance / immunobreakPenalty then
        return
    end

    -- Apply immunobreak effect (lower resistance rank) and apply special message.
    target:setMod(immunobreakModId, immunobreakValue + 1) -- TODO: Add equipment modifier (x2) here (Chironic Hose).
    spell:setModifier(xi.msg.actionModifier.IMMUNOBREAK)
end

-- Disable cyclomatic complexity check for this function:
-- luacheck: ignore 561
xi.combat.action.executeSpellEnfeeblement = function(actor, target, spell, fedData)
    local params = validateParameters(actor, target, fedData)

    ------------------------------
    -- STEP 1: Check spell nullification.
    ------------------------------
    -- Early return: Target is immune.
    if xi.data.statusEffect.isTargetImmune(target, params.effectId, params.magicalElement) then
        spell:setMsg(xi.msg.basic.MAGIC_COMPLETE_RESIST)
        return params.effectId
    end

    -- Early return: Target triggers resist trait.
    if xi.data.statusEffect.isTargetResistant(actor, target, params.effectId) then
        spell:setModifier(xi.msg.actionModifier.RESIST)
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        return params.effectId
    end

    -- Early return: Target has an status effect that invalidates current (Outright incompatible or higher tier).
    if xi.data.statusEffect.isEffectNullified(target, params.effectId, params.tier) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return params.effectId
    end

    -- Early return: Target negates the effect.
    if params.fealty and target:hasStatusEffect(xi.effect.FEALTY) then
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        return params.effectId
    end

    -- Early return: Out of cone.
    if params.isConal and not target:isInfront(actor, 32) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return params.effectId
    end

    -- Early return: Out of gaze.
    if params.isGaze and not target:isFacing(actor) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return params.effectId
    end

    ------------------------------
    -- STEP 2: Calculate resist tier.
    ------------------------------
    local stymie         = params.stymie and actor:hasStatusEffect(xi.effect.STYMIE)
    local resistanceRate = not stymie and xi.combat.magicHitRate.calculateResistRate(actor, target, params) or 1

    -- Early return: Resist rate too high.
    if not xi.data.statusEffect.isResistRateSuccessfull(params.effectId, resistanceRate, params.resistRate) then
        executeImmunobreak(actor, target, spell, params)

        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        return params.effectId
    end

    ------------------------------
    -- STEP 3: Calculate effect power and duration.
    ------------------------------
    local power    = params.power
    local duration = params.duration

    -- Specific: Enfeebling magic.
    if params.skillType == xi.skill.ENFEEBLING_MAGIC then
        -- Saboteur.
        local saboteur       = params.saboteur and actor:hasStatusEffect(xi.effect.SABOTEUR)
        local saboteurFactor = target:isNM() and 0.25 or 1

        power    = saboteur and math.floor(power * (1 + saboteurFactor + actor:getMod(xi.mod.ENHANCES_SABOTEUR) / 100)) or power
        duration = saboteur and math.floor(duration * (1 + saboteurFactor + actor:getMod(xi.mod.ENHANCES_SABOTEUR) / 100)) or duration

        -- After Saboteur according to bg-wiki
        if actor:getMainJob() == xi.job.RDM then
            -- RDM Merit: Enfeebling Magic Duration
            duration = duration + actor:getMerit(xi.merit.ENFEEBLING_MAGIC_DURATION)

            -- RDM Job Point: Enfeebling Magic Duration
            duration = duration + actor:getJobPointLevel(xi.jp.ENFEEBLE_DURATION)

            -- RDM Job Point: Stymie effect
            if actor:hasStatusEffect(xi.effect.STYMIE) then
                duration = duration + actor:getJobPointLevel(xi.jp.STYMIE_EFFECT)
            end
        end

        -- General Enfeebling potency and duration modifiers.
        power    = math.floor(power * (1 + actor:getMod(xi.mod.ENF_MAG_POTENCY) / 100))
        duration = math.floor(duration * (1 + actor:getMod(xi.mod.ENF_MAG_DURATION) / 100))

    -- Specific: Songs.
    elseif params.skillType == xi.skill.SINGING then
        -- Soul Voice or Marcato.
        if actor:hasStatusEffect(xi.effect.SOUL_VOICE) then
            power = math.floor(power * 2)
        elseif actor:getStatusEffect(xi.effect.MARCATO) then
            power = math.floor(power * 1.5)
        end

        -- Gear.
        duration = math.floor(duration * (1 + params.songPlus / 10 + actor:getMod(xi.mod.SONG_DURATION_BONUS) / 100))

        -- Troubadour.
        if actor:hasStatusEffect(xi.effect.TROUBADOUR) then
            duration = math.floor(duration * 2)
        end

        -- Job Points.
        if actor:hasStatusEffect(xi.effect.CLARION_CALL) then
            duration = duration + actor:getJobPointLevel(xi.jp.CLARION_CALL_EFFECT) * 2
        end

        if actor:hasStatusEffect(xi.effect.TENUTO) then
            duration = duration + actor:getJobPointLevel(xi.jp.TENUTO_EFFECT) * 2
        end
    end

    -- Final additional bonuses. (Example: Specific spell JP additions to power and duration)
    power    = power + params.powerBonus
    duration = duration + params.durationBonus

    -- Apply caps.
    power    = utils.clamp(power, 1, params.powerMax)
    duration = utils.clamp(duration, 1, params.durationMax)

    -- All: Resist rate factor.
    duration = math.floor(duration * resistanceRate)

    ------------------------------
    -- STEP 4: Handle application.
    ------------------------------
    if not target:addStatusEffect(params.effectId, { power = power, tick = params.tick, duration = duration, subType = params.subType, subPower = params.subPower, tier = params.tier, origin = actor }) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return params.effectId
    end

    ------------------------------
    -- STEP 5: Handle message.
    ------------------------------
    if params.magicBurstTier > 0 then
        spell:setMsg(params.messageBurst)
        actor:triggerRoeEvent(xi.roeTrigger.MAGIC_BURST)
    else
        spell:setMsg(params.message)
    end

    return params.effectId
end
