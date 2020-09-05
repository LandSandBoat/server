-----------------------------------------
-- Spell: Sandspray
-- Blinds enemies within a fan-shaped area originating from the caster
-- Spell cost: 43 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 2
-- Stat Bonus: VIT+1
-- Level: 66
-- Casting Time: 3 seconds
-- Recast Time: 90 seconds
-- Magic Bursts on: Compression, Gravitation, and Darkness
-- Combos: Clear Mind
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local typeEffect = tpz.effect.BLINDNESS
    local dINT = caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)
    local params = {}
    params.diff = nil
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 0
    params.effect = typeEffect
    local resist = applyResistanceEffect(caster, target, spell, params)
    local duration = 120 * resist
    local power = 25

    if (resist > 0.5) then -- Do it!
        if (target:addStatusEffect(typeEffect, power, 0, duration)) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return typeEffect
end
