-----------------------------------
-- Global file for spells AoE type and radius calculations.
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.magicAoE = xi.combat.magicAoE or {}

---Return total song radius after factoring String equipment bonus
---@param caster CBaseEntity
---@param spell CSpell
---@return integer
xi.combat.magicAoE.calculateSongRadius = function(caster, spell)
    local baseRadius = spell:getRadius()
    local rangeType  = caster:getWeaponSkillType(xi.slot.RANGED)
    local aoeType    = spell:isAoE()

    -- Spell is not AoE or caster is under Pianissimo
    if
        aoeType == xi.magic.aoe.NONE or
        (aoeType == xi.magic.aoe.PIANISSIMO and
            caster:hasStatusEffect(xi.effect.PIANISSIMO))
    then
        return 0
    end

    -- Caster is not BRD or does not have a String instrument equipped
    if
        caster:getMainJob() ~= xi.job.BRD or
        rangeType ~= xi.skill.STRING_INSTRUMENT or
        spell:getSpellGroup() ~= xi.magic.spellGroup.SONG
    then
        return baseRadius
    end

    -- Range scales from 1.0x to 2.0x based on string skill vs song level skill cap
    -- Range is always whole, no partial yalm bonus range.
    local songLevel   = spell:getLevel(xi.job.BRD)
    local stringSkill = caster:getSkillLevel(xi.skill.STRING_INSTRUMENT)
    local skillCap    = xi.data.skillLevel.getSkillCap(songLevel, xi.skillRank.C)
    local multiplier  = utils.clamp(stringSkill / skillCap, 1.0, 2.0)

    return math.floor(baseRadius * multiplier)
end

---Calculate spell AoE type and radius based on caster modifiers.
---@param caster CBaseEntity
---@param spell CSpell
---@return [xi.magic.aoe, number]
xi.combat.magicAoE.calculateTypeAndRadius = function(caster, spell)
    local baseType    = spell:isAoE()
    local baseRadius  = spell:getRadius()
    local spellFamily = spell:getSpellFamily()
    local spellGroup  = spell:getSpellGroup()

    -- Until proven otherwise, these effects only apply to players and trusts.
    if
        not caster:isPC() and
        not caster:isTrust()
    then
        return { baseType, baseRadius }
    end

    -- Majesty converts Cure and Protect spells to 10y AoE
    if caster:hasStatusEffect(xi.effect.MAJESTY) then
        if
            spellFamily == xi.magic.spellFamily.CURE or
            spellFamily == xi.magic.spellFamily.PROTECT
        then
            return { xi.magic.aoe.RADIAL, 10 }
        end
    end

    -- Accession / Divine Veil converts eligible spells to 10y AoE
    if baseType == xi.magic.aoe.RADIAL_ACCE then
        if caster:hasStatusEffect(xi.effect.ACCESSION) then
            return { xi.magic.aoe.RADIAL, 10 }
        end

        -- Divine Veil: -na spells become AoE with Divine Seal or AOE_NA mod chance
        if
            caster:hasTrait(xi.trait.DIVINE_VEIL) and
            (spellFamily == xi.magic.spellFamily.NA or spell:getID() == xi.magic.spell.ERASE) and
            (caster:hasStatusEffect(xi.effect.DIVINE_SEAL) or math.random(100) <= caster:getMod(xi.mod.AOE_NA))
        then
            return { xi.magic.aoe.RADIAL, 10 }
        end

        return { xi.magic.aoe.NONE, 0 }
    end

    -- Manifestation converts eligible spells to 10y AoE
    if
        caster:hasStatusEffect(xi.effect.MANIFESTATION) and
        baseType == xi.magic.aoe.RADIAL_MANI
    then
        return { xi.magic.aoe.RADIAL, 10 }
    end

    -- Theurgic Focus halves the AoE radius of -ra spells
    if
        caster:hasStatusEffect(xi.effect.THEURGIC_FOCUS) and
        spellFamily >= xi.magic.spellFamily.FIRA and
        spellFamily <= xi.magic.spellFamily.WATERA
    then
        return { xi.magic.aoe.RADIAL, math.floor(baseRadius / 2) }
    end

    -- Songs: Pianissimo forces single target, otherwise calculate BRD radius bonus with String equipment
    if spellGroup == xi.magic.spellGroup.SONG then
        -- Single target songs are always single targets
        if baseType == xi.magic.aoe.NONE then
            return { xi.magic.aoe.NONE, 0 }
        end

        if
            caster:hasStatusEffect(xi.effect.PIANISSIMO) and
            baseType == xi.magic.aoe.PIANISSIMO
        then
            -- Delete Pianissimo now as it has no use beyond AoE calculations
            caster:delStatusEffect(xi.effect.PIANISSIMO)
            return { xi.magic.aoe.NONE, 0 }
        end

        return { xi.magic.aoe.RADIAL, xi.combat.magicAoE.calculateSongRadius(caster, spell) }
    end

    -- Diffusion converts eligible spells to 10y AoE
    if
        caster:hasStatusEffect(xi.effect.DIFFUSION) and
        baseType == xi.magic.aoe.DIFFUSION
    then
        return { xi.magic.aoe.RADIAL, 10 }
    end

    -- Convergence forces BLU offensive magic spells to be single target
    if
        caster:hasStatusEffect(xi.effect.CONVERGENCE) and
        spellGroup == xi.magic.spellGroup.BLUE and
        spell:getElement() ~= xi.element.NONE
    then
        return { xi.magic.aoe.NONE, 0 }
    end

    -- Certain equipment convert Utsusemi spells to 10y AoE
    if
        caster:getMod(xi.mod.UTSUSEMI_AOE) ~= 0 and
        spellFamily == xi.magic.spellFamily.UTSUSEMI
    then
        return { xi.magic.aoe.RADIAL, 10 }
    end

    return { baseType, baseRadius }
end
