-----------------------------------
-- Spell: Absorb-STR
-- Steals an enemy's strength.
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if
        target:hasStatusEffect(xi.effect.STR_DOWN) or
        caster:hasStatusEffect(xi.effect.STR_BOOST)
    then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no effect
    else
        -- local dINT = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
        local params = {}
        params.diff = nil
        params.attribute = xi.mod.INT
        params.skillType = xi.skill.DARK_MAGIC
        params.bonus = 0
        params.effect = nil
        local resist = applyResistance(caster, target, spell, params)
        if resist <= 0.125 then
            spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        else
            spell:setMsg(xi.msg.basic.MAGIC_ABSORB_STR)
            caster:addStatusEffect(xi.effect.STR_BOOST, xi.settings.main.ABSORB_SPELL_AMOUNT * resist * ((100 + (caster:getMod(xi.mod.AUGMENTS_ABSORB))) / 100), xi.settings.main.ABSORB_SPELL_TICK, xi.settings.main.ABSORB_SPELL_AMOUNT * xi.settings.main.ABSORB_SPELL_TICK) -- caster gains STR
            target:addStatusEffect(xi.effect.STR_DOWN, xi.settings.main.ABSORB_SPELL_AMOUNT * resist * ((100 + (caster:getMod(xi.mod.AUGMENTS_ABSORB))) / 100), xi.settings.main.ABSORB_SPELL_TICK, xi.settings.main.ABSORB_SPELL_AMOUNT * xi.settings.main.ABSORB_SPELL_TICK)    -- target loses STR
        end
    end

    return xi.effect.STR_DOWN
end

return spellObject
