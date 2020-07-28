-----------------------------------------
-- Spell: Lowing
-- Gives enemies within range a powerful disease that prevents recovery of HP and MP
-- Spell cost: 66 MP
-- Monster Type: Beasts
-- Spell Type: Magical (Fire)
-- Blue Magic Points: 2
-- Stat Bonus: HP-5
-- Level: 71
-- Casting Time: 7 seconds
-- Recast Time: 56 seconds
-- Magic Bursts on: Liquefaction, Fusion, and Light
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
    local params = {}
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.effect = tpz.effect.PLAGUE
    local resist = applyResistance(caster, target, spell, params)
    local duration = 60 * resist
    local power = 5

    if (resist > 0.5) then -- Do it!
        if (target:addStatusEffect(params.effect, power, 0, duration)) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return params.effect
end
