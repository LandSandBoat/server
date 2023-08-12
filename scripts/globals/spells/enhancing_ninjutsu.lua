-----------------------------------
-- Enhancing Spell Utilities
-----------------------------------
xi = xi or {}
xi.spells = xi.spells or {}
xi.spells.enhancing = xi.spells.enhancing or {}
-----------------------------------
-- Table variables.
local pTable =
{
-- Structure:            [spellId] = { Tier, Main_Effect, Power, Duration, Always_Overwrite },
    [xi.magic.spell.GEKKA_ICHI   ] = { 1, xi.effect.ENMITY_BOOST,     30, 300, true  },
    [xi.magic.spell.KAKKA_ICHI   ] = { 1, xi.effect.STORE_TP,         10, 180, true  },
    [xi.magic.spell.MIGAWARI_ICHI] = { 1, xi.effect.MIGAWARI,          0,  60, true  },
    [xi.magic.spell.MONOMI_ICHI  ] = { 1, xi.effect.SNEAK,             0, 120, false },
    [xi.magic.spell.MYOSHU_ICHI  ] = { 1, xi.effect.SUBTLE_BLOW_PLUS, 10, 180, true  },
    [xi.magic.spell.TONKO_ICHI   ] = { 1, xi.effect.INVISIBLE,         0, 180, false },
    [xi.magic.spell.TONKO_NI     ] = { 2, xi.effect.INVISIBLE,         0, 300, false },
    [xi.magic.spell.UTSUSEMI_ICHI] = { 1, xi.effect.COPY_IMAGE,        3,   0, false },
    [xi.magic.spell.UTSUSEMI_NI  ] = { 1, xi.effect.COPY_IMAGE,        4,   0, false },
    [xi.magic.spell.UTSUSEMI_SAN ] = { 1, xi.effect.COPY_IMAGE,        5,   0, false },
    [xi.magic.spell.YAIN_ICHI    ] = { 1, xi.effect.PAX,              15, 300, true  },
}

-- Ninjutsu Potency function.
xi.spells.enhancing.calculateNinjutsuPower = function(caster, target, spell, spellId, tier, spellEffect)
    local power    = pTable[spellId][3]
    local subPower = 0

    -- Migawari
    if spellEffect == xi.effect.MIGAWARI then
        power = math.floor(caster:getSkillLevel(xi.skill.NINJUTSU) / 5)
        subPower = 100

    -- Utsusemi
    elseif spellEffect == xi.effect.COPY_IMAGE then
        power    = power + target:getMod(xi.mod.UTSUSEMI_BONUS)
        subPower = xi.effect.COPY_IMAGE_3

        -- Utsusemi: Ni non-ninja penalty
        if
            spellId == xi.magic.spell.UTSUSEMI_NI and
            caster:getMainJob() ~= xi.job.NIN
        then
            power = power - 1
        end

        if power > 3 then
            subPower = subPower + 1
        end
    end

    return power, subPower
end

-- Main function for Enhancing Spells.
xi.spells.enhancing.useEnhancingNinjutsu = function(caster, target, spell)
    local spellId = spell:getID()
    -- Get Variables from Parameters Table.
    local tier            = pTable[spellId][1]
    local spellEffect     = pTable[spellId][2]
    local duration        = pTable[spellId][4]
    local alwaysOverwrite = pTable[spellId][5]

    -- Other
    local paramThree = 0
    --------------------------------------------------
    -- Calculate Spell Potency and subpower.
    --------------------------------------------------
    local power, subPower = xi.spells.enhancing.calculateNinjutsuPower(caster, target, spell, spellId, tier, spellEffect)

    ------------------------------
    -- Handle exceptions.
    ------------------------------
    -- Gekka
    if spellEffect == xi.effect.ENMITY_BOOST then
        target:delStatusEffect(xi.effect.PAX)

    -- Monomi / Tonko
    elseif spellEffect == xi.effect.SNEAK or spellEffect == xi.effect.INVISIBLE then
        paramThree = 10

    -- Yain
    elseif spellEffect == xi.effect.PAX then
        target:delStatusEffect(xi.effect.ENMITY_BOOST)
    end

    ------------------------------------------------------------
    -- Change message when higher effect or "Always overwrite".
    ------------------------------------------------------------
    if alwaysOverwrite then
        target:delStatusEffect(spellEffect)
        target:addStatusEffect(spellEffect, power, paramThree, duration, 0, subPower)

    -- Utsusemi exception.
    elseif not alwaysOverwrite and spellEffect == xi.effect.COPY_IMAGE then
        local targetEffect = target:getStatusEffect(xi.effect.COPY_IMAGE)

        -- Third Eye and Utsusemi don't stack. Utsusemi removes Third Eye.
        if target:hasStatusEffect(xi.effect.THIRD_EYE) then
            target:delStatusEffect(xi.effect.THIRD_EYE)
        end

        paramThree = pTable[spellId][3] - 2

        if targetEffect == nil or targetEffect:getPower() <= paramThree then
            target:addStatusEffectEx(xi.effect.COPY_IMAGE, subPower, paramThree, duration, 900, 0, power) -- Not a mistake.
            spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end

    else
        if target:addStatusEffect(spellEffect, power, paramThree, duration, 0, subPower) then
            spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- No effect.
        end
    end

    return spellEffect
end
