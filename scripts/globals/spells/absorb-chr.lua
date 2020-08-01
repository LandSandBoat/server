--------------------------------------
-- Spell: Absorb-CHR
-- Steals an enemy's Charism.
--------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)

    if (target:hasStatusEffect(tpz.effect.CHR_DOWN) or caster:hasStatusEffect(tpz.effect.CHR_BOOST)) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT) -- no effect
    else
        local dINT = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
        local params = {}
        params.diff = nil
        params.attribute = tpz.mod.INT
        params.skillType = 37
        params.bonus = 0
        params.effect = nil
        local resist = applyResistance(caster, target, spell, params)
        if (resist <= 0.125) then
            spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_ABSORB_CHR)
            caster:addStatusEffect(tpz.effect.CHR_BOOST, ABSORB_SPELL_AMOUNT*resist*((100+(caster:getMod(tpz.mod.AUGMENTS_ABSORB)))/100), ABSORB_SPELL_TICK, ABSORB_SPELL_AMOUNT*ABSORB_SPELL_TICK) -- caster gains CHR
            target:addStatusEffect(tpz.effect.CHR_DOWN, ABSORB_SPELL_AMOUNT*resist*((100+(caster:getMod(tpz.mod.AUGMENTS_ABSORB)))/100), ABSORB_SPELL_TICK, ABSORB_SPELL_AMOUNT*ABSORB_SPELL_TICK)    -- target loses CHR
        end
    end
    return tpz.effect.CHR_DOWN
end
