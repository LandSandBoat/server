-----------------------------------
-- Blue Magic utilities
-- Used for Blue Magic spells.
-----------------------------------
require('scripts/globals/combat/physical_utilities')
require('scripts/globals/combat/magic_hit_rate')
require('scripts/globals/magic')
require('scripts/globals/mobskills')
require('scripts/globals/spells/damage_spell')
-----------------------------------
xi = xi or {}
xi.spells = xi.spells or {}
xi.spells.blue = xi.spells.blue or {}
-----------------------------------

-- The TP modifier (currently unused)
xi.spells.blue.tpMod =
{
    NONE          = 0,
    CRITICAL      = 1,
    DAMAGE        = 2,
    ACC           = 3,
    ATTACK        = 4,
    DURATION      = 5,
    EFFECT_CHANCE = 6,
}

-----------------------------------
-- Local functions
-----------------------------------

-- Get alpha (level-dependent multiplier on WSC)
local function calculateAlpha(level)
    if level <= 60 then
        return math.ceil(100 - level / 6) / 100
    elseif level <= 75 then
        return math.ceil(100 - (level - 40) / 2) / 100
    else
        return 0.83
    end
end

-- Get WSC
local function calculateWSC(attacker, params)
    local alpha  = calculateAlpha(attacker:getMainLvl())
    local wscSTR = attacker:getStat(xi.mod.STR) * params.str_wsc
    local wscDEX = attacker:getStat(xi.mod.DEX) * params.dex_wsc
    local wscVIT = attacker:getStat(xi.mod.VIT) * params.vit_wsc
    local wscAGI = attacker:getStat(xi.mod.AGI) * params.agi_wsc
    local wscINT = attacker:getStat(xi.mod.INT) * params.int_wsc
    local wscMND = attacker:getStat(xi.mod.MND) * params.mnd_wsc
    local wscCHR = attacker:getStat(xi.mod.CHR) * params.chr_wsc

    local wsc = (wscSTR + wscDEX + wscVIT + wscAGI + wscINT + wscMND + wscCHR) * alpha

    return wsc
end

-- Get cRatio
local function calculatecRatio(ratio, atk_lvl, def_lvl)
    -- Get ratio with level penalty
    local levelcor = 0
    if atk_lvl < def_lvl then
        levelcor = 0.05 * (def_lvl - atk_lvl)
    end

    ratio = ratio - levelcor
    ratio = utils.clamp(ratio, 0, 2)

    -- Get cRatiomin
    local cratiomin = 0
    if ratio < 1.25 then
        cratiomin = 1.2 * ratio - 0.5
    elseif ratio >= 1.25 and ratio <= 1.5 then
        cratiomin = 1
    elseif ratio > 1.5 and ratio <= 2 then
        cratiomin = 1.2 * ratio - 0.8
    end

    -- Get cRatiomax
    local cratiomax = 0
    if ratio < 0.5 then
        cratiomax = 0.4 + 1.2 * ratio
    elseif ratio <= 0.833 and ratio >= 0.5 then
        cratiomax = 1
    elseif ratio <= 2 and ratio > 0.833 then
        cratiomax = 1.2 * ratio
    end

    -- Return data
    local cratio = {}
    if cratiomin < 0 then
        cratiomin = 0
    end

    cratio[1] = cratiomin
    cratio[2] = cratiomax

    return cratio
end

-- Get the fTP multiplier (by applying 2 straight lines between ftp0-ftp1500 and ftp1500-ftp3000)
local function calculatefTP(tp, ftp0, ftp1500, ftp3000)
    tp = utils.clamp(tp, 0, 3000)

    if tp >= 1500 then
        return ftp1500 + (ftp3000 - ftp1500) * (tp - 1500) / 1500
    else
        return ftp0 + (ftp1500 - ftp0) * tp / 1500
    end
end

-- Get fSTR
local function calculatefSTR(dSTR)
    local fSTR2 = 0

    if dSTR >= 12 then
        fSTR2 = dSTR + 4
    elseif dSTR >= 6 then
        fSTR2 = dSTR + 6
    elseif dSTR >= 1 then
        fSTR2 = dSTR + 7
    elseif dSTR >= -2 then
        fSTR2 = dSTR + 8
    elseif dSTR >= -7 then
        fSTR2 = dSTR + 9
    elseif dSTR >= -15 then
        fSTR2 = dSTR + 10
    elseif dSTR >= -21 then
        fSTR2 = dSTR + 12
    else
        fSTR2 = dSTR + 13
    end

    return fSTR2 / 2
end

-- Get hitrate
local function calculateHitrate(attacker, target, bonusacc)
    -- your mainhand may not be a sword, so hit rate would vary here
    -- TODO: verify hit rate of physical blue magic with different weapons
    return xi.combat.physicalHitRate.getPhysicalHitRate(attacker, target, bonusacc + attacker:getMerit(xi.merit.PHYSICAL_POTENCY) * 2, xi.attackAnimation.RIGHT_ATTACK, false)
end

-- Get the effect of ecosystem correlation
local function calculateCorrelation(spellEcosystem, monsterEcosystem, merits)
    local effect = utils.getEcosystemStrengthBonus(spellEcosystem, monsterEcosystem) * 0.25

    if effect > 0 then -- merits don't impose a penalty, only a benefit in case of strength
        effect = effect + 0.001 * merits
    end

    return effect
end

-----------------------------------
-- Global functions
-----------------------------------

-- Get the damage for a physical Blue Magic spell
xi.spells.blue.usePhysicalSpell = function(caster, target, spell, params)
    -----------------------
    -- Get final D value --
    -----------------------

    -- Initial D value
    local initialD = math.floor(caster:getSkillLevel(xi.skill.BLUE_MAGIC) * 0.11) * 2 + 3
    initialD       = utils.clamp(initialD, 0, params.duppercap)

    -- fSTR
    local fStr = calculatefSTR(caster:getStat(xi.mod.STR) - target:getStat(xi.mod.VIT))
    if fStr > 22 then
        if params.ignorefstrcap == nil then -- Smite of Rage / Grand Slam don't have this cap applied
            fStr = 22
        end
    end

    -- Multiplier, bonus WSC
    local multiplier = params.multiplier or 1
    local bonusWSC   = 0

    -- BLU AF3 bonus (triples the base WSC when it procs)
    if  math.random(1, 100) <= caster:getMod(xi.mod.AUGMENT_BLU_MAGIC) then
        bonusWSC = 2
    end

    -- Chain Affinity -- TODO: add 'Damage/Accuracy/Critical Hit Chance varies with TP'
    if caster:getStatusEffect(xi.effect.CHAIN_AFFINITY) then
        local tp   = caster:getTP() + caster:getMerit(xi.merit.ENCHAINMENT) -- Total TP available
        tp         = utils.clamp(tp, 0, 3000)
        multiplier = calculatefTP(tp, params.multiplier, params.tp150, params.tp300)
        bonusWSC   = bonusWSC + 1 -- Chain Affinity doubles base WSC
    end

    -- WSC
    local wsc = calculateWSC(caster, params)
    wsc       = wsc + wsc * bonusWSC -- Bonus WSC from AF3/CA

    -- Monster correlation
    local correlationMultiplier = calculateCorrelation(params.ecosystem, target:getEcosystem(), caster:getMerit(xi.merit.MONSTER_CORRELATION))

    -- Azure Lore
    if caster:getStatusEffect(xi.effect.AZURE_LORE) then
        multiplier = params.azuretp
    end

    -- Final D
    local finalD = math.floor(initialD + fStr + wsc)
    -- TODO: Implement ENHANCES_CHAIN_AFFINITY. Increase base damage of spell, but not limited to spell's damage cap
    -- ENHANCES_CHAIN_AFFINITY should also not modify skillchain damage

    ----------------------------------------------
    -- Get the possible pDIF range and hit rate --
    ----------------------------------------------

    if params.offcratiomod == nil then -- For all spells except Cannonball, which uses a DEF mod
        params.offcratiomod = caster:getStat(xi.mod.ATT)
    end

    params.offcratiomod = params.offcratiomod * (caster:getMerit(xi.merit.PHYSICAL_POTENCY) + 100) / 100
    params.bonusacc     = params.bonusacc == nil and 0 or params.bonusacc
    params.tphitslanded = 0

    -- params.critchance will only be non-nil if base critchance is passed from spell lua
    local nativecrit  = xi.combat.physical.calculateSwingCriticalRate(caster, target, 0, false)
    params.critchance = params.critchance == nil and 0 or utils.clamp(params.critchance / 100 + nativecrit, 0.05, 0.95)

    local cratio  = calculatecRatio(params.offcratiomod / target:getStat(xi.mod.DEF), caster:getMainLvl(), target:getMainLvl())
    local hitrate = calculateHitrate(caster, target, params.bonusacc)

    -------------------------
    -- Perform the attacks --
    -------------------------

    local hitsdone          = 0
    local hitslanded        = 0
    local finaldmg          = 0
    local sneakIsApplicable = false
    local trickAttackTarget = nil

    if spell:isAoE() == 0 and params.attackType ~= xi.attackType.RANGED then
        if
            caster:hasStatusEffect(xi.effect.SNEAK_ATTACK) and
            (caster:isBehind(target) or caster:hasStatusEffect(xi.effect.HIDE))
        then
            sneakIsApplicable = true
        end

        if caster:hasStatusEffect(xi.effect.TRICK_ATTACK) then
            trickAttackTarget = caster:getTrickAttackChar(target)
        end
    end

    while hitsdone < params.numhits do
        local chance = math.random()

        if
            sneakIsApplicable or
            chance <= hitrate
        then
            -- TODO: Check for shadow absorbs. Right now the whole spell will be absorbed by one shadow before it even gets here.

            -- Generate a random pDIF between min and max
            local pdif = math.random(cratio[1] * 1000, cratio[2] * 1000)
            pdif       = pdif / 1000

            if
                sneakIsApplicable or
                math.random() < params.critchance
            then
                pdif = pdif + 1
            end

            -- Add it to our final damage
            if hitsdone == 0 then
                finaldmg = finaldmg + finalD * (multiplier + correlationMultiplier) * pdif -- first hit gets full multiplier
            else
                finaldmg = finaldmg + finalD * (1 + correlationMultiplier) * pdif
            end

            hitslanded        = hitslanded + 1
            sneakIsApplicable = false

            -- Store number of hits that did > 0 damage
            if finaldmg > 0 then
                params.tphitslanded = params.tphitslanded + 1
            end
        end

        if params.attackType ~= xi.attackType.RANGED then
            caster:delStatusEffect(xi.effect.SNEAK_ATTACK)
            caster:delStatusEffect(xi.effect.TRICK_ATTACK)
        end

        hitsdone = hitsdone + 1
    end

    if finaldmg <= 0 then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.spells.blue.applySpellDamage(caster, target, spell, finaldmg, params, trickAttackTarget)
end

-- Get the damage for a magical Blue Magic spell. Called from spell scripts.
xi.spells.blue.useMagicalSpell = function(caster, target, spell, params)
    -- In individual magical spells, don't use params.effect for the added effect
    -- This would affect the resistance check for damage here
    -- We just want that to affect the resistance check for the added effect
    -- Use params.addedEffect instead

    -- Initial values
    local initialD   = utils.clamp(caster:getMainLvl() + 2, 0, params.duppercap)
    params.skillType = xi.skill.BLUE_MAGIC

    -- WSC
    local wsc           = calculateWSC(caster, params)
    local wscMultiplier = 1

    -- BLU AF3 bonus (triples the base WSC when it procs)
    if math.random(1, 100) <= caster:getMod(xi.mod.AUGMENT_BLU_MAGIC) then
        wscMultiplier = wscMultiplier + 1
    end

    if caster:hasStatusEffect(xi.effect.BURST_AFFINITY) then
        wscMultiplier = wscMultiplier + 1 + caster:getMod(xi.mod.ENHANCES_BURST_AFFINITY) / 100
    end

    wsc = wsc * wscMultiplier -- Bonus WSC from AF3/BA

    -- INT/MND/CHR dmg bonuses
    params.diff     = caster:getStat(params.attribute) - target:getStat(params.attribute)
    local statBonus = params.diff * params.tMultiplier

    -- Azure Lore
    local azureBonus = 0
    if caster:getStatusEffect(xi.effect.AZURE_LORE) then
        azureBonus = params.azureBonus or 0
    end

    -- Monster correlation
    local correlationMultiplier = calculateCorrelation(params.ecosystem, target:getEcosystem(), caster:getMerit(xi.merit.MONSTER_CORRELATION))

    -- Data
    local spellId            = spell:getID()
    local spellElement       = spell:getElement()
    local spellGroup         = spell:getSpellGroup()
    local skillType          = xi.skill.BLUE_MAGIC
    local _, skillchainCount = xi.magicburst.formMagicBurst(spellElement, target) -- External function. Not present in magic.lua.

    -- Final D value
    local finalDamage    = (initialD + wsc) * (params.multiplier + azureBonus + correlationMultiplier) + statBonus

    finalDamage = math.floor(finalDamage * xi.combat.magicHitRate.calculateResistRate(caster, target, spellGroup, skillType, 0, spellElement, params.attribute, 0, 0))
    finalDamage = math.floor(finalDamage * xi.spells.damage.calculateMTDR(spell))
    finalDamage = math.floor(finalDamage * xi.spells.damage.calculateElementalStaffBonus(caster, spellElement))
    finalDamage = math.floor(finalDamage * xi.spells.damage.calculateSDT(target, spellElement))
    finalDamage = math.floor(finalDamage * xi.spells.damage.calculateDayAndWeather(caster, spellElement, false))
    finalDamage = math.floor(finalDamage * xi.spells.damage.calculateMagicBonusDiff(caster, target, spellId, skillType, spellElement))

    if
        caster:hasStatusEffect(xi.effect.BURST_AFFINITY) or
        caster:hasStatusEffect(xi.effect.AZURE_LORE)
    then
        if skillchainCount > 0 then
            finalDamage = math.floor(finalDamage * xi.spells.damage.calculateIfMagicBurst(target, spellElement, skillchainCount))
            finalDamage = math.floor(finalDamage * xi.spells.damage.calculateIfMagicBurstBonus(caster, target, spellId, skillType, spellElement))

            spell:setMsg(spell:getMagicBurstMessage()) -- "Magic Burst!"

            caster:triggerRoeEvent(xi.roeTrigger.MAGIC_BURST)
        end

        caster:delStatusEffectSilent(xi.effect.BURST_AFFINITY)
    end

    finalDamage = math.floor(finalDamage * xi.spells.damage.calculateEbullienceMultiplier(caster, spellGroup))
    finalDamage = math.floor(finalDamage * xi.settings.main.BLUE_POWER)

    return xi.spells.blue.applySpellDamage(caster, target, spell, finalDamage, params, nil)
end

-- Spell script Helper function.
xi.spells.blue.useDrainSpell = function(caster, target, spell, params, damageCap, mpDrain)
    local finalDamage = 0

    -- Early returns
    if
        target:isUndead() or
        xi.spells.damage.calculateNukeAbsorbOrNullify(target, spell:getElement()) == 0 -- Drain spells cannot be absorbed, but they can be nullified.
    then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)

        return 0
    end

    -- Base damage
    finalDamage = math.floor(caster:getSkillLevel(xi.skill.BLUE_MAGIC) * 0.11)
    finalDamage = math.floor(finalDamage * params.dmgMultiplier)
    if damageCap > 0 then
        finalDamage = utils.clamp(finalDamage, 0, damageCap)
    end

    -- Data
    local spellId            = spell:getID()
    local spellElement       = spell:getElement()
    local spellGroup         = spell:getSpellGroup()
    local skillType          = xi.skill.BLUE_MAGIC
    local _, skillchainCount = xi.magicburst.formMagicBurst(spellElement, target) -- External function. Not present in magic.lua.

    finalDamage = math.floor(finalDamage * xi.combat.magicHitRate.calculateResistRate(caster, target, spellGroup, skillType, 0, spellElement, params.attribute, 0, 0))
    finalDamage = math.floor(finalDamage * xi.spells.damage.calculateMTDR(spell))
    finalDamage = math.floor(finalDamage * xi.spells.damage.calculateElementalStaffBonus(caster, spellElement))
    finalDamage = math.floor(finalDamage * xi.spells.damage.calculateSDT(target, spellElement))
    finalDamage = math.floor(finalDamage * xi.spells.damage.calculateDayAndWeather(caster, spellElement, false))
    finalDamage = math.floor(finalDamage * xi.spells.damage.calculateMagicBonusDiff(caster, target, spellId, skillType, spellElement))

    if
        caster:hasStatusEffect(xi.effect.BURST_AFFINITY) or
        caster:hasStatusEffect(xi.effect.AZURE_LORE)
    then
        if skillchainCount > 0 then
            finalDamage = math.floor(finalDamage * xi.spells.damage.calculateIfMagicBurst(target, spellElement, skillchainCount))
            finalDamage = math.floor(finalDamage * xi.spells.damage.calculateIfMagicBurstBonus(caster, target, spellId, skillType, spellElement))

            spell:setMsg(spell:getMagicBurstMessage()) -- "Magic Burst!"

            caster:triggerRoeEvent(xi.roeTrigger.MAGIC_BURST)
        end

        caster:delStatusEffectSilent(xi.effect.BURST_AFFINITY)
    end

    finalDamage = math.floor(finalDamage * xi.spells.damage.calculateEbullienceMultiplier(caster, spellGroup))
    finalDamage = math.floor(finalDamage * xi.spells.damage.calculateTMDA(target, spellElement))
    finalDamage = math.floor(finalDamage * xi.settings.main.BLUE_POWER)

    -- MP drain
    if mpDrain then
        finalDamage = utils.clamp(finalDamage, 0, target:getMP())

        target:delMP(finalDamage)
        caster:addMP(finalDamage)

        return finalDamage
    end

    -- Handle Phalanx, One for All, Stoneskin and target HP (Cant be higher than current HP)
    finalDamage = utils.clamp(finalDamage - target:getMod(xi.mod.PHALANX), 0, 99999)
    finalDamage = utils.clamp(utils.oneforall(target, finalDamage), 0, 99999)
    finalDamage = utils.clamp(utils.stoneskin(target, finalDamage), -99999, 99999)
    finalDamage = utils.clamp(finalDamage, 0, target:getHP())

    -- Check if the mob has a damage cap
    finalDamage = target:checkDamageCap(finalDamage)

    target:takeSpellDamage(caster, spell, finalDamage, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL + spell:getElement())

    if not target:isPC() then
        target:updateEnmityFromDamage(caster, finalDamage)
    end

    target:handleAfflatusMiseryDamage(finalDamage)
    caster:addHP(finalDamage)

    return finalDamage
end

-- Breath-type blue magic spells.
xi.spells.blue.useBreathSpell = function(caster, target, spell, params)
    -- Early return.
    if
        params.isConal and               -- Conal breath spells
        not target:isInfront(caster, 32) -- Conal check (45° cone)
    then
        return 0
    end

    -- Initial damage
    local dmg = caster:getHP() / params.hpMod
    if params.lvlMod > 0 then
        dmg = dmg + caster:getMainLvl() / params.lvlMod
    end

    -- Parameters
    local spellId      = spell:getID() or 0
    local spellFamily  = spell:getSpellFamily() or 0
    local spellElement = spell:getElement() or 0
    local attackType   = params.attackType or xi.attackType.NONE
    local damageType   = params.damageType or xi.damageType.NONE

    -- Multipliers
    local correlationMultiplier       = 1 + calculateCorrelation(params.ecosystem, target:getEcosystem(), caster:getMerit(xi.merit.MONSTER_CORRELATION))
    local breathSDT                   = 1 + caster:getMod(xi.mod.BREATH_DMG_DEALT) / 100

    local nukeAbsorbOrNullify         = xi.spells.damage.calculateNukeAbsorbOrNullify(target, spellElement)
    local targetMagicDamageAdjustment = xi.spells.damage.calculateTMDA(target, spellElement)
    local multipleTargetReduction     = xi.spells.damage.calculateMTDR(spell)
    local elementalStaffBonus         = xi.spells.damage.calculateElementalStaffBonus(caster, spellElement)
    local elementalAffinityBonus      = xi.spells.damage.calculateElementalAffinityBonus(caster, spellElement)
    local resistTier                  = xi.combat.magicHitRate.calculateResistRate(caster, target, spellFamily, xi.skill.BLUE_MAGIC, 0, spellElement, 0, 0, 0)
    local additionalResistTier        = xi.spells.damage.calculateAdditionalResistTier(caster, target, spellElement)
    local elementalSDT                = xi.spells.damage.calculateSDT(target, spellElement)
    local dayAndWeather               = xi.spells.damage.calculateDayAndWeather(caster, spellElement, false)
    local magicBonusDiff              = xi.spells.damage.calculateMagicBonusDiff(caster, target, spellId, xi.skill.BLUE_MAGIC, spellElement)
    local skillTypeMultiplier         = xi.spells.damage.calculateSkillTypeMultiplier(xi.skill.BLUE_MAGIC)
    local ninFutaeBonus               = xi.spells.damage.calculateNinFutaeBonus(caster, xi.skill.BLUE_MAGIC)
    local ninjutsuMultiplier          = xi.spells.damage.calculateNinjutsuMultiplier(caster, target, xi.skill.BLUE_MAGIC)
    local scarletDeliriumMultiplier   = xi.combat.damage.scarletDeliriumMultiplier(caster)
    local areaOfEffectResistance      = xi.spells.damage.calculateAreaOfEffectResistance(target, spell)

    dmg = math.floor(dmg * correlationMultiplier)
    dmg = math.floor(dmg * breathSDT)
    dmg = math.floor(dmg * targetMagicDamageAdjustment)
    dmg = math.floor(dmg * multipleTargetReduction)
    dmg = math.floor(dmg * elementalStaffBonus)
    dmg = math.floor(dmg * elementalAffinityBonus)
    dmg = math.floor(dmg * resistTier)
    dmg = math.floor(dmg * additionalResistTier)
    dmg = math.floor(dmg * elementalSDT)
    dmg = math.floor(dmg * dayAndWeather)
    dmg = math.floor(dmg * magicBonusDiff)
    dmg = math.floor(dmg * skillTypeMultiplier)
    dmg = math.floor(dmg * ninFutaeBonus)
    dmg = math.floor(dmg * ninjutsuMultiplier)
    dmg = math.floor(dmg * scarletDeliriumMultiplier)
    dmg = math.floor(dmg * areaOfEffectResistance)

    -- Handle "Nuke Wall". It must be handled after all previous calculations, but before clamp.
    if nukeAbsorbOrNullify > 0 then
        local nukeWallFactor = xi.spells.damage.calculateNukeWallFactor(target, spellElement, dmg)
        dmg          = math.floor(dmg * nukeWallFactor)
    end

    -- Apply damage
    dmg = target:breathDmgTaken(dmg)

    -- Handle Magic Absorb message and HP recovery.
    if dmg < 0 then
        dmg = target:addHP(-dmg)
        spell:setMsg(xi.msg.basic.MAGIC_RECOVERS_HP)

        return dmg
    end

    -- Final adjustments.
    if dmg > 0 then
        dmg = utils.clamp(dmg - target:getMod(xi.mod.PHALANX), 0, 99999)
        dmg = utils.clamp(utils.oneforall(target, dmg), 0, 99999)
        dmg = utils.clamp(utils.stoneskin(target, dmg), -99999, 99999)
        dmg = utils.clamp(dmg, 0, target:getHP())
        dmg = target:checkDamageCap(dmg)
    end

    target:takeSpellDamage(caster, spell, dmg, attackType, damageType)

    -- Handle TP
    local tpHits        = params.tphitslanded or 0
    local extraTPGained = xi.combat.tp.calculateTPGainOnMagicalDamage(dmg, caster, target) * math.max(tpHits - 1, 0) -- Calculate extra TP gained from multihits. takeSpellDamage accounts for one already.
    target:addTP(extraTPGained)

    -- Handle Afflatus Misery.
    target:handleAfflatusMiseryDamage(dmg)

    -- Handle Enmity.
    target:updateEnmityFromDamage(caster, dmg)

    return dmg
end

-- Apply spell damage
xi.spells.blue.applySpellDamage = function(caster, target, spell, dmg, params, trickAttackTarget)
    dmg                 = math.floor(dmg * xi.settings.main.BLUE_POWER)
    local attackType    = params.attackType or xi.attackType.NONE
    local damageType    = params.damageType or xi.damageType.NONE
    local tpHits        = params.tphitslanded or 0
    local extraTPGained = xi.combat.tp.calculateTPGainOnMagicalDamage(dmg, caster, target) * math.max(tpHits - 1, 0) -- Calculate extra TP gained from multihits. takeSpellDamage accounts for one already.

    -- handle MDT, One For All, Liement
    if attackType == xi.attackType.MAGICAL then
        local absorbOrNullify = xi.spells.damage.calculateNukeAbsorbOrNullify(target, spell:getElement())
        dmg                   = math.floor(dmg * absorbOrNullify)

        if dmg < 0 then
            target:takeSpellDamage(caster, spell, dmg, attackType, damageType)
            target:addTP(extraTPGained)
            -- TODO: verify Afflatus/enmity from absorb?
            return dmg
        end

        local targetMagicDamageAdjustment = xi.spells.damage.calculateTMDA(target, spell:getElement())
        dmg                               = math.floor(dmg * targetMagicDamageAdjustment)

        dmg = utils.oneforall(target, dmg)
    end

    -- handle Phalanx
    if dmg > 0 then
        dmg = utils.clamp(dmg - target:getMod(xi.mod.PHALANX), 0, 99999)
    end

    -- handle stoneskin
    dmg = utils.stoneskin(target, dmg)

    -- Check if the mob has a damage cap
    dmg = target:checkDamageCap(dmg)

    target:takeSpellDamage(caster, spell, dmg, attackType, damageType)
    target:addTP(extraTPGained)

    if not target:isPC() then
        if trickAttackTarget then
            target:updateEnmityFromDamage(trickAttackTarget, dmg)
        else
            target:updateEnmityFromDamage(caster, dmg)
        end
    end

    target:handleAfflatusMiseryDamage(dmg)

    return dmg
end

-- Get the duration of an enhancing Blue Magic spell
xi.spells.blue.calculateDurationWithDiffusion = function(caster, duration)
    if caster:hasStatusEffect(xi.effect.DIFFUSION) then
        local merits = caster:getMerit(xi.merit.DIFFUSION)

        if merits > 0 then -- each merit after the first increases duration by 5%
            duration = duration + (merits - 5) * duration / 100
        end

        caster:delStatusEffect(xi.effect.DIFFUSION)
    end

    return duration
end

-- Perform an enfeebling Blue Magic spell
xi.spells.blue.useEnfeeblingSpell = function(caster, target, spell, params)
    local spellElement = spell:getElement()

    -- Early return: Out of cone.
    if
        params.isConal and
        not target:isInfront(caster, 64)
    then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return params.effect
    end

    -- Early return: Out of gaze.
    if
        params.isGaze and
        (not target:isFacing(caster) or not caster:isFacing(target))
    then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return params.effect
    end

    -- Early return: Target is immune.
    if xi.data.statusEffect.isTargetImmune(target, params.effect, spellElement) then
        spell:setMsg(xi.msg.basic.MAGIC_COMPLETE_RESIST)
        return params.effect
    end

    -- Early return: Trait nullification trigger.
    if xi.data.statusEffect.isTargetResistant(caster, target, params.effect) then
        spell:setModifier(xi.msg.actionModifier.RESIST)
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        return params.effect
    end

    -- Early return: Target already has an status effect that nullifies current.
    if xi.data.statusEffect.isEffectNullified(target, params.effect) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return params.effect
    end

    -- Early return: Regular resist.
    local resist = xi.combat.magicHitRate.calculateResistRate(caster, target, 0, xi.skill.BLUE_MAGIC, 0, spellElement, xi.mod.INT, 0, 0)
    if resist < params.resistThreshold then
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        return params.effect
    end

    if target:addStatusEffect(params.effect, params.power, params.tick, math.floor(params.duration * resist)) then
        -- Add "Magic Burst!" message
        local _, skillchainCount = xi.magicburst.formMagicBurst(spellElement, target) -- External function. Not present in magic.lua.

        if skillchainCount > 0 then
            spell:setMsg(xi.msg.basic.MAGIC_BURST_ENFEEB_IS)
            caster:triggerRoeEvent(xi.roeTrigger.MAGIC_BURST)
        else
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return params.effect
end

-- Perform a curative Blue Magic spell
xi.spells.blue.useCuringSpell = function(caster, target, spell, params)
    local power    = getCurePowerOld(caster)
    local divisor  = params.divisor0
    local constant = params.constant0

    if power > params.powerThreshold2 then
        divisor  = params.divisor2
        constant = params.constant2
    elseif power > params.powerThreshold1 then
        divisor  = params.divisor1
        constant = params.constant1
    end

    local final = getCureFinal(caster, spell, getBaseCureOld(power, divisor, constant), params.minCure, true)
    final       = final + final * target:getMod(xi.mod.CURE_POTENCY_RCVD) / 100
    final       = final * xi.settings.main.CURE_POWER
    final       = utils.clamp(final, 0, target:getMaxHP() - target:getHP())

    target:addHP(final)
    target:wakeUp()
    caster:updateEnmityFromCure(target, final)

    if target:getID() == spell:getPrimaryTargetID() then
        spell:setMsg(xi.msg.basic.MAGIC_RECOVERS_HP)
    else
        spell:setMsg(xi.msg.basic.SELF_HEAL_SECONDARY)
    end

    return final
end

xi.spells.blue.applyBlueAdditionalEffect = function(caster, target, params, effectTable)
    -- Sanitize parameters.
    local element = params.damageType and params.damageType - 5 or 0
    local stat    = params.attribute and params.attribute or xi.mod.INT
    if params.attackType == xi.attackType.BREATH then
        stat = 0
    end

    -- Calculate resist and early return.
    local resist = xi.combat.magicHitRate.calculateResistRate(caster, target, 0, xi.skill.BLUE_MAGIC, 0, element, stat, 0, 0)

    if resist <= 0.25 then
        return
    end

    for entry = 1, #effectTable do
        local effect   = effectTable[entry][1]
        local power    = effectTable[entry][2]
        local tick     = effectTable[entry][3]
        local duration = effectTable[entry][4]

        if
            not xi.data.statusEffect.isTargetImmune(target, effect, element) and   -- Target isn't immune.
            not xi.data.statusEffect.isTargetResistant(caster, target, effect) and -- Target didn't trigger a job trait resistance.
            not xi.data.statusEffect.isEffectNullified(target, effect)             -- Target doesn't have an status effect that nullifies current.
        then
            target:addStatusEffect(effect, power, tick, math.floor(duration * resist))
        end
    end
end

--[[
+-------+
| NOTES |
+-------+
- Spell values (multiplier, TP, D, WSC, TP etc) from:
    - https://www.bg-wiki.com/ffxi/Calculating_Blue_Magic_Damage
    - https://ffxiclopedia.fandom.com/wiki/Calculating_Blue_Magic_Damage
    - BG-wiki spell pages
    - Blue Gartr threads with data, such as
        https://www.bluegartr.com/threads/37619-Blue-Mage-Best-thread-ever?p=5832112&viewfull=1#post5832112
        https://www.bluegartr.com/threads/37619-Blue-Mage-Best-thread-ever?p=5437135&viewfull=1#post5437135
        https://www.bluegartr.com/threads/107650-Random-Question-Thread-XXIV-Occupy-the-RQT?p=4906565&viewfull=1#post4906565
    - When values were absent, spell values were decided based on Blue Gartr threads and Wiki page discussions.
    - Assumed INT as the main magic accuracy modifier for physical spells' additional effects (when no data was found).
]]--
