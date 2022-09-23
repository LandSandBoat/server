-----------------------------------
-- Enhancing Spell Utilities
-----------------------------------
require("scripts/globals/spells/parameters")
require("scripts/globals/spell_data")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
xi = xi or {}
xi.spells = xi.spells or {}
xi.spells.spell_enhancing_ninjutsu = xi.spells.spell_enhancing_ninjutsu or {}
-----------------------------------
-- Table variables.
local enhancingTable = xi.spells.parameters.enhancingNinjutsu

-- Ninjutsu Potency function.
xi.spells.spell_enhancing_ninjutsu.calculateNinjutsuPower = function(caster, target, spell, spellId, tier, spellEffect)
    local power    = enhancingTable[spellId][3]
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
        if spellId == xi.magic.spell.UTSUSEMI_NI and caster:getMainJob() ~= xi.job.NIN then
            power = power - 1
        end

        if power > 3 then
            subPower = subPower + 1
        end
    end

    return power, subPower
end

-- Main function for Enhancing Spells.
xi.spells.spell_enhancing_ninjutsu.useEnhancingNinjutsu = function(caster, target, spell)
    local spellId = spell:getID()
    -- Get Variables from Parameters Table.
    local tier            = enhancingTable[spellId][1]
    local spellEffect     = enhancingTable[spellId][2]
    local duration        = enhancingTable[spellId][4]
    local alwaysOverwrite = enhancingTable[spellId][5]

    -- Other
    local paramThree = 0
    --------------------------------------------------
    -- Calculate Spell Potency and subpower.
    --------------------------------------------------
    local power, subPower = xi.spells.spell_enhancing_ninjutsu.calculateNinjutsuPower(caster, target, spell, spellId, tier, spellEffect)

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

        paramThree = enhancingTable[spellId][3] - 2

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
