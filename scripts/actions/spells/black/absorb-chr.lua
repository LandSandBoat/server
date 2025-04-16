-----------------------------------
-- Spell: Absorb-CHR
-- Steals an enemy's Charisma.
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if target:hasStatusEffect(xi.effect.CHR_DOWN) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    else
        -- Always overwrite the caster's CHR_BOOST
        caster:delStatusEffectSilent(xi.effect.CHR_BOOST)

        local params = {}
        params.diff = nil
        params.attribute = xi.mod.INT
        params.skillType = xi.skill.DARK_MAGIC
        params.bonus = 0
        params.effect = nil

        local resist = applyResistanceEffect(caster, target, spell, params)
        if resist <= 0.125 then
            spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        else
            spell:setMsg(xi.msg.basic.MAGIC_ABSORB_CHR)

            -- Calculate final power
            local base = xi.settings.main.ABSORB_SPELL_AMOUNT
            local tick = xi.settings.main.ABSORB_SPELL_TICK
            local duration = base * tick
            local mod = ((100 + caster:getMod(xi.mod.AUGMENTS_ABSORB)) / 100)
            local finalPower = base * resist * mod

            -- Buff caster
            caster:addStatusEffect(xi.effect.CHR_BOOST, finalPower, tick, duration)

            -- Debuff target (proper Exuviation-compatible)
            target:addStatusEffectEx(xi.effect.CHR_DOWN, xi.effect.CHR_DOWN, -finalPower, tick, duration)
        end
    end

    return xi.effect.CHR_DOWN
end

return spellObject
