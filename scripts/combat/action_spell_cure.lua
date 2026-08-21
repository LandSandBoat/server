-----------------------------------
-- Global file for spells that restore HP with the cure formulas
-----------------------------------
require('scripts/globals/spells/damage_spell')
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.action = xi.combat.action or {}
-----------------------------------

-----------------------------------
-- Local functions to ensure defaults are set.
-----------------------------------
local function validateParameters(actor, target, fedData)
    local params = {}

    -- Base cure parameters. Base cure is calculated in the spell script.
    params.baseCure        = fedData.baseCure or 0
    params.minCure         = fedData.minCure or 0

    -- Action general properties.
    params.skillType       = fedData.skillType or xi.skill.HEALING_MAGIC

    -- Job specific properties.
    params.solaceStoneskin = fedData.solaceStoneskin or false -- White magic single target cures grant stoneskin under Afflatus Solace.
    params.miseryCap       = fedData.miseryCap or 0           -- Cura family: base cure cap after adding Afflatus Misery bonus.

    -- Enmity. When 0, updateEnmityFromCure uses the regular cure enmity formula.
    params.fixedCE         = fedData.fixedCE or 0             -- Cura family and Cure V: fixed CE.
    params.fixedVE         = fedData.fixedVE or 0             -- Cura family and Cure V: fixed VE.

    return params
end

local function isValidHealTarget(actor, target)
    return target:getAllegiance() == actor:getAllegiance() and
        (target:getObjType() == xi.objType.PC or
        target:getObjType() == xi.objType.MOB or
        target:getObjType() == xi.objType.TRUST or
        target:getObjType() == xi.objType.FELLOW)
end

-- Afflatus Misery bonus (Cura family).
-- The bonus is stored on the first (self) target so all targets get the same boost.
local function applyAfflatusMisery(actor, target, baseCure, miseryCap)
    -- Early return: No Afflatus Misery bonus to apply.
    if
        miseryCap == 0 or
        not actor:hasStatusEffect(xi.effect.AFFLATUS_MISERY)
    then
        return baseCure
    end

    if actor:getID() == target:getID() then
        actor:setLocalVar('Misery_Power', actor:getMod(xi.mod.AFFLATUS_MISERY))
    end

    actor:setMod(xi.mod.AFFLATUS_MISERY, 0) -- Afflatus Misery bonus gets used up.

    return math.min(baseCure + actor:getLocalVar('Misery_Power'), miseryCap)
end

-- Cure potency, day and weather, Rapture and Divine Seal. Floored after each step.
local function applyActorMultipliers(actor, spell, skillType, baseCure)
    local curePotency     = math.min(actor:getMod(xi.mod.CURE_POTENCY), 50) / 100    -- Caps at 50%.
    local curePotencyII   = math.min(actor:getMod(xi.mod.CURE_POTENCY_II), 30) / 100 -- Caps at 30%.
    local dayWeatherBonus = xi.spells.damage.calculateDayAndWeather(actor, spell:getElement(), false)

    local divineSeal = 1
    if actor:hasStatusEffect(xi.effect.DIVINE_SEAL) then
        divineSeal = 2
    end

    local rapture = 1
    if
        skillType == xi.skill.HEALING_MAGIC and
        actor:hasStatusEffect(xi.effect.RAPTURE)
    then
        rapture = 1.5 + actor:getMod(xi.mod.RAPTURE_AMOUNT) / 100
        actor:delStatusEffectSilent(xi.effect.RAPTURE)
    end

    local finalCure = math.floor(baseCure)
    finalCure       = math.floor(finalCure * (1 + curePotency + curePotencyII))
    finalCure       = math.floor(finalCure * dayWeatherBonus)
    finalCure       = math.floor(finalCure * rapture)
    finalCure       = math.floor(finalCure * divineSeal)

    return finalCure
end

-- Afflatus Solace stoneskin (White magic single target cures).
-- Based on cure amount before target.
local function applySolaceStoneskin(actor, target, healAmount)
    -- Early return: Target already has Stoneskin.
    if target:hasStatusEffect(xi.effect.STONESKIN) then
        return
    end

    local stoneskinPercent = 0.25
    local equippedBody     = actor:getEquipID(xi.slot.BODY)
    if equippedBody == xi.item.ORISON_BLIAUT_P1 then
        stoneskinPercent = 0.30
    elseif equippedBody == xi.item.ORISON_BLIAUT_P2 then
        stoneskinPercent = 0.35
    end

    local solaceStoneskin = math.floor(healAmount * stoneskinPercent) * (1 + actor:getMerit(xi.merit.ANIMUS_SOLACE) / 100)

    target:addStatusEffect(xi.effect.STONESKIN, { power = solaceStoneskin, duration = 25, origin = actor, tier = 1 })
end

-----------------------------------
-- Function to calculate the base cure. Used in spell scripts.
-- The fedData table can have "modern" and "old" formula tiers because SE changed the healing formula for cures.
-- The old formula is used primarily for BLU magic, which follows the old formula for cures.
-- Modern tiers: { powerCap, divisor, constant, basePower }
-- Old tiers: { powerFloor, divisor, constant }
-- Spells without modern tiers (Curagas, blue magic) always use the old formula.
-----------------------------------
xi.combat.action.calculateSpellCureBase = function(actor, cureTiers)
    if
        cureTiers.old and
        (not cureTiers.modern or xi.settings.main.USE_OLD_CURE_FORMULA)
    then
        local power = 3 * actor:getStat(xi.mod.MND) + actor:getStat(xi.mod.VIT) + 3 * math.floor(actor:getSkillLevel(xi.skill.HEALING_MAGIC) / 5)

        for _, tier in ipairs(cureTiers.old) do
            if power > tier.powerFloor then
                return (power / 2) / tier.divisor + tier.constant
            end
        end

        return 0
    end

    local power = math.floor(actor:getStat(xi.mod.MND) / 2) + math.floor(actor:getStat(xi.mod.VIT) / 4) + actor:getSkillLevel(xi.skill.HEALING_MAGIC)

    for _, tier in ipairs(cureTiers.modern) do
        if power < tier.powerCap then
            return (power - tier.basePower) / tier.divisor + tier.constant
        end
    end

    return 0
end

-----------------------------------
-- Global function called from the spell script
-----------------------------------
xi.combat.action.executeSpellCure = function(actor, target, spell, fedData)
    local params      = validateParameters(actor, target, fedData)
    local validTarget = isValidHealTarget(actor, target)

    -- Early return: Players get no effect on invalid targets.
    if not validTarget and actor:getObjType() == xi.objType.PC then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)

        return 0
    end

    -- Calculate base cure.
    local baseCure = params.baseCure
    baseCure       = applyAfflatusMisery(actor, target, params.baseCure, params.miseryCap)
    baseCure       = math.max(baseCure, params.minCure)

    -- Calculate actor multipliers.
    local finalCure = applyActorMultipliers(actor, spell, params.skillType, baseCure)

    if
        params.solaceStoneskin and
        actor:hasStatusEffect(xi.effect.AFFLATUS_SOLACE)
    then
        applySolaceStoneskin(actor, target, finalCure)
    end

    -- Calculate target multipliers and server settings.
    finalCure = math.floor(finalCure * (1 + target:getMod(xi.mod.CURE_POTENCY_RCVD) / 100))
    finalCure = math.floor(finalCure * xi.settings.main.CURE_POWER)
    finalCure = utils.clamp(finalCure, 0, target:getMaxHP() - target:getHP())

    -- Handle application, enmity and message.
    target:addHP(finalCure)

    -- Monsters healing an invalid target skip enmity.
    if validTarget then
        if params.fixedCE > 0 then
            actor:updateEnmityFromCure(target, finalCure, params.fixedCE, params.fixedVE)
        else
            actor:updateEnmityFromCure(target, finalCure)
        end
    end

    if target:getID() == spell:getPrimaryTargetID() then
        spell:setMsg(xi.msg.basic.MAGIC_RECOVERS_HP)
    else
        spell:setMsg(xi.msg.basic.SELF_HEAL_SECONDARY)
    end

    -- MP granted from equipment (White magic only).
    if
        params.skillType == xi.skill.HEALING_MAGIC and
        actor:getMod(xi.mod.CURE2MP_PERCENT) > 0
    then
        actor:addMP(finalCure * actor:getMod(xi.mod.CURE2MP_PERCENT) / 100)
    end

    return finalCure
end
