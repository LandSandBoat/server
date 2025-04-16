-----------------------------------
-- Spell: Absorb-STR
-- Steals an enemy's Strength.
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if target:hasStatusEffect(xi.effect.STR_DOWN) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    else
        caster:delStatusEffectSilent(xi.effect.STR_BOOST)

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
            spell:setMsg(xi.msg.basic.MAGIC_ABSORB_STR)

            local base = xi.settings.main.ABSORB_SPELL_AMOUNT
            local tick = xi.settings.main.ABSORB_SPELL_TICK
            local duration = base * tick
            local mod = ((100 + caster:getMod(xi.mod.AUGMENTS_ABSORB)) / 100)
            local finalPower = base * resist * mod

            caster:addStatusEffect(xi.effect.STR_BOOST, finalPower, tick, duration)
            target:addStatusEffectEx(xi.effect.STR_DOWN, xi.effect.STR_DOWN, -finalPower, tick, duration)
        end
    end

    return xi.effect.STR_DOWN
end

return spellObject
