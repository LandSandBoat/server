--------------------------------------
-- Spell: Absorb-ACC
-- Steals an enemy's accuracy.
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

    if (caster:hasStatusEffect(tpz.effect.ACCURACY_BOOST)) then
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
            spell:setMsg(tpz.msg.basic.MAGIC_ABSORB_ACC)
            caster:addStatusEffect(tpz.effect.ACCURACY_BOOST, ABSORB_SPELL_AMOUNT*resist*((100+(caster:getMod(tpz.mod.AUGMENTS_ABSORB)))/100), ABSORB_SPELL_TICK, ABSORB_SPELL_AMOUNT*ABSORB_SPELL_TICK) -- caster gains ACC
            target:addStatusEffect(tpz.effect.ACCURACY_DOWN, ABSORB_SPELL_AMOUNT*resist*((100+(caster:getMod(tpz.mod.AUGMENTS_ABSORB)))/100), ABSORB_SPELL_TICK, ABSORB_SPELL_AMOUNT*ABSORB_SPELL_TICK)    -- target loses ACC
        end
    end
    return tpz.effect.ACCURACY_BOOST
end
