-----------------------------------
-- Absorb Spell Utilities
-----------------------------------
require("scripts/globals/spell_data")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
xi = xi or {}
xi.spells = xi.spells or {}
xi.spells.absorb = xi.spells.absorb or {}
-----------------------------------
-- Table variables.
local pTableAbsorb =
{
-- Structure:           [spellId] = { Positive_Effect, Negative_Effect, Duration, Message },
    [xi.magic.spell.ABSORB_ATTRI] = { xi.effect.NONE,           xi.effect.NONE,           0, xi.msg.basic.STATUS_DRAIN     },
    [xi.magic.spell.ABSORB_TP   ] = { xi.effect.NONE,           xi.effect.NONE,           0, xi.msg.basic.MAGIC_ABSORB_TP  },
    [xi.magic.spell.ABSORB_ACC  ] = { xi.effect.ACCURACY_BOOST, xi.effect.ACCURACY_DOWN, 90, xi.msg.basic.MAGIC_ABSORB_ACC },
    [xi.magic.spell.ABSORB_STR  ] = { xi.effect.STR_BOOST,      xi.effect.STR_DOWN,      90, xi.msg.basic.MAGIC_ABSORB_STR },
    [xi.magic.spell.ABSORB_DEX  ] = { xi.effect.DEX_BOOST,      xi.effect.DEX_DOWN,      90, xi.msg.basic.MAGIC_ABSORB_DEX },
    [xi.magic.spell.ABSORB_VIT  ] = { xi.effect.VIT_BOOST,      xi.effect.VIT_DOWN,      90, xi.msg.basic.MAGIC_ABSORB_VIT },
    [xi.magic.spell.ABSORB_AGI  ] = { xi.effect.AGI_BOOST,      xi.effect.AGI_DOWN,      90, xi.msg.basic.MAGIC_ABSORB_AGI },
    [xi.magic.spell.ABSORB_INT  ] = { xi.effect.INT_BOOST,      xi.effect.INT_DOWN,      90, xi.msg.basic.MAGIC_ABSORB_INT },
    [xi.magic.spell.ABSORB_MND  ] = { xi.effect.MND_BOOST,      xi.effect.MND_DOWN,      90, xi.msg.basic.MAGIC_ABSORB_MND },
    [xi.magic.spell.ABSORB_CHR  ] = { xi.effect.CHR_BOOST,      xi.effect.CHR_DOWN,      90, xi.msg.basic.MAGIC_ABSORB_CHR },
}

local pTableDrain =
{
-- Structure:        [spellId] = { Tier, Under_Skill_Mult, Skill_Multiplier, Skill_Bonus, Message },
    [xi.magic.spell.DRAIN    ] = { 1, 1.0, 0.625, 132.5, xi.msg.basic.MAGIC_DRAIN_HP },
    [xi.magic.spell.DRAIN_II ] = { 2, 1.0, 1.350,     0, xi.msg.basic.MAGIC_DRAIN_HP },
    [xi.magic.spell.DRAIN_III] = { 3, 1.0, 1.800,     0, xi.msg.basic.MAGIC_DRAIN_HP },
    [xi.magic.spell.ASPIR    ] = { 1, 1.0, 0.400,     0, xi.msg.basic.MAGIC_DRAIN_MP },
    [xi.magic.spell.ASPIR_II ] = { 2, 1.5, 0.600,     0, xi.msg.basic.MAGIC_DRAIN_MP },
    [xi.magic.spell.ASPIR_III] = { 3, 2.0, 0.800,     0, xi.msg.basic.MAGIC_DRAIN_MP },
}

-- Main function for Aspir spells
xi.spells.absorb.useAspirSpell = function(caster, target, spell)
    -- https://www.bg-wiki.com/ffxi/Aspir
    -- https://www.bg-wiki.com/ffxi/Aspir_II
    -- https://www.bg-wiki.com/ffxi/Aspir_III
    -- Calculate base drain amount and potency
    local spellId        = spell:getID()
    local underSkillMult = pTableDrain[spellId][2]
    local skillMult      = pTableDrain[spellId][3]
    local skillBonus     = pTableDrain[spellId][4]
    local message        = pTableDrain[spellId][5]
    local skillLevel     = caster:getSkillLevel(xi.skill.DARK_MAGIC)
    local base           = ((skillLevel / 3) + 20) * underSkillMult
    local netherVoid     = 1 + (xi.spells.absorb.getNetherVoidBonus(caster, spell) / 100)
    local potency        = math.random(50, 100) / 100

    if caster:getSkillLevel(xi.skill.DARK_MAGIC) > 300 then
        base = (skillLevel * skillMult) + skillBonus
    end

    local aspir = base * netherVoid * potency

    -- Get the resist multiplier (1x if no resist)
    local params = {}
        params.diff      = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
        params.attribute = xi.mod.INT
        params.skillType = xi.skill.DARK_MAGIC
        params.bonus     = 1.0
    local resist = applyResistance(caster, target, spell, params)
    -- Get the resisted damage
    aspir = aspir * resist
    -- Add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    aspir = addBonuses(caster, spell, target, aspir)
    -- Add in target adjustment
    aspir = adjustForTarget(target, aspir, spell:getElement())

    -- Make final adjustments
    if aspir < 0 then
        aspir = 0
    end

    aspir = aspir * xi.settings.main.DARK_POWER

    if target:isUndead() then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- No effect

        return aspir
    end

    if (target:getMP() > aspir) then
        caster:addMP(aspir)
        target:delMP(aspir)
    else
        aspir = target:getMP()

        caster:addMP(aspir)
        target:delMP(aspir)
    end

    spell:setMsg(message)

    return aspir
end

-- Main function for Drain spells
xi.spells.absorb.useDrainSpell = function(caster, target, spell)
    -- https://www.bg-wiki.com/ffxi/Drain
    -- https://www.bg-wiki.com/ffxi/Drain_II
    -- https://www.bg-wiki.com/ffxi/Drain_III
    -- Calculate base drain amount and potency
    local spellId        = spell:getID()
    local tier           = pTableDrain[spellId][1]
    local underSkillMult = pTableDrain[spellId][2]
    local skillMult      = pTableDrain[spellId][3]
    local skillBonus     = pTableDrain[spellId][4]
    local message        = pTableDrain[spellId][5]
    local skillLevel     = caster:getSkillLevel(xi.skill.DARK_MAGIC)
    local base           = (skillLevel + 20) * underSkillMult
    local netherVoid     = 1 + (xi.spells.absorb.getNetherVoidBonus(caster, spell) / 100)
    local potency        = math.random(50, 100) / 100

    if skillLevel > 300 then
        base = (skillLevel * skillMult) + skillBonus
    end

    local drain = base * netherVoid * potency

    -- Get the resist multiplier (1x if no resist)
    local params = {}
        params.diff      = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
        params.attribute = xi.mod.INT
        params.skillType = xi.skill.DARK_MAGIC
        params.bonus     = 1.0
    local resist = applyResistance(caster, target, spell, params)
    -- Get the resisted damage
    drain = drain * resist
    -- Add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    drain = addBonuses(caster, spell, target, drain)
    -- Add in target adjustment
    drain = adjustForTarget(target, drain, spell:getElement())

    -- Make final adjustments
    if drain < 0 then
        drain = 0
    end

    drain = drain * xi.settings.main.DARK_POWER

    if target:getHP() < drain then
        drain = target:getHP()
    end

    if target:isUndead() then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- No effect

        return drain
    end

    drain = finalMagicAdjustments(caster, target, spell, drain)

    -- Handle Drain II and III Max HP Boost
    if tier > 1 then
        local leftOver = (caster:getHP() + drain) - caster:getMaxHP()

        if leftOver > 0 then
            caster:addStatusEffect(xi.effect.MAX_HP_BOOST, (leftOver / caster:getMaxHP()) * 100, 0, 180)
        end
    end

    caster:addHP(drain)
    spell:setMsg(message)

    return drain
end

-- Main function for Absorb-Attri
xi.spells.absorb.useEffectAbsorb = function(caster, target, spell)
    local spellId = spell:getID()
    local params  = {}
        params.attribute = xi.mod.INT
        params.skillType = xi.skill.DARK_MAGIC
    -- Get the resist multiplier (1x if no resist)
    local resist        = applyResistance(caster, target, spell, params)
    local effectsTotal  = 1 + xi.spells.absorb.getNetherVoidBonus(caster, spell)
    local effectsStolen = {}
    local message       = pTableAbsorb[spellId][4]

    if resist > 0.0625 then
        spell:setMsg(message)

        for i = 1, effectsTotal do
            effectsStolen[i] = caster:stealStatusEffect(target, xi.effectFlag.DISPELABLE)
        end

        if effectsStolen[1] == 0 then
            -- Failed to steal effect
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return #effectsStolen
end

-- Main function for Stat (STR/DEX/etc) absorbing spells
xi.spells.absorb.useStatAbsorb = function(caster, target, spell)
    local spellId = spell:getID()
    -- Get Variables from Parameters Table.
    local spellEffect = pTableAbsorb[spellId][1]
    local negEffect   = pTableAbsorb[spellId][2]
    local message     = pTableAbsorb[spellId][4]

    if
        caster:hasStatusEffect(spellEffect) or
        target:hasStatusEffect(negEffect)
    then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- No effect
    else
        -- local dINT = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
        local params = {}
            params.diff      = nil
            params.attribute = xi.mod.INT
            params.skillType = xi.skill.DARK_MAGIC
            params.bonus     = 0
            params.effect    = nil
        local base       = utils.clamp(caster:getMainLvl() / 4.5, 9, 22)
        local resist     = applyResistance(caster, target, spell, params)
        local augAbsorb  = 1 + (caster:getMod(xi.mod.AUGMENTS_ABSORB) / 100)
        local netherVoid = 1 + (xi.spells.absorb.getNetherVoidBonus(caster, spell) / 100)
        local power      = base * resist * augAbsorb * netherVoid
        local tick       = xi.settings.main.ABSORB_SPELL_TICK
        local duration   = calculateDuration(pTableAbsorb[spellId][3], spell:getSkillType(), spell:getSpellGroup(), caster, target)

        if resist <= 0.125 then
            spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        else
            spell:setMsg(message)
            caster:addStatusEffect(spellEffect, power, tick, duration) -- Caster gains Stat
            target:addStatusEffect(negEffect, power, tick, duration)   -- Target loses Stat
        end
    end

    return negEffect
end

-- Main function for TP-Absorb
xi.spells.absorb.useTpAbsorb = function(caster, target, spell)
    local spellId   = spell:getID()
    local currentTP = target:getTP()
    local cap       = currentTP * 0.4  -- Caps TP drained at 40% of the target's current TP
    local tp        = math.random(100, cap) -- Drains at least 100 TP
    local message   = pTableAbsorb[spellId][4]

    -- Get resist multiplier (1x if no resist)
    local params = {}
        params.attribute = xi.mod.INT
        params.skillType = xi.skill.DARK_MAGIC
    local resist = applyResistance(caster, target, spell, params)

    -- Get the resisted damage
    tp = tp * resist

    -- Add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    tp = addBonuses(caster, spell, target, tp)

    -- Add in target adjustment
    tp = adjustForTarget(target, tp, spell:getElement())

    -- Add in final adjustments
    if resist <= 0.125 then
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        tp = 0
    else
        spell:setMsg(message)

        local enhancesAbsorb = 1 + (caster:getMod(xi.mod.ENHANCES_ABSORB_TP) / 100)
        local augmentsAbsorb = 1 + (caster:getMod(xi.mod.AUGMENTS_ABSORB) / 100)

        tp = tp * enhancesAbsorb * augmentsAbsorb

        if currentTP < tp then
            tp = currentTP
        end

        if tp > cap then
            tp = cap
        end

        -- Drain TP
        caster:addTP(tp)
        target:addTP(-tp)
    end

    return tp
end

-- Nether Void Absorb Bonus and handling
xi.spells.absorb.getNetherVoidBonus = function(caster, spell)
    local bonus   = 0
    local spellId = spell:getID()

    if caster:hasStatusEffect(xi.effect.NETHER_VOID) then
        if spellId == xi.magic.spell.ABSORB_ATTRI then
            -- Adds +1 effect absorbed with no Job Points, up to a total of 2 effects absorbed
            -- Adds +1 effect absorbed every 10 Job Points, up to a total of 4 effects absorbed
            bonus = 1 + math.floor(caster:getJobPointLevel(xi.jp.NETHER_VOID_EFFECT) / 10)
        else
            -- All other Absorb type spells receive a % increase to the amount drained
            -- Effect power set in job_utils/dark_knight.lua
            bonus = caster:getStatusEffect(xi.effect.NETHER_VOID):getPower()
        end

        caster:delStatusEffect(xi.effect.NETHER_VOID)
    end

    return bonus
end
