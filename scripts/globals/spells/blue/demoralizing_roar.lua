-----------------------------------
-- Spell: Demoralizing Roar
-- Weakens the attack of enemies within range.
-- Spell cost: 46 MP
-- Monster Type: Wivre
-- Spell Type: Magical (Water)
-- Blue Magic Points: 4
-- Stat Bonus: STR-2 VIT+3
-- Level: 80
-- Casting Time: ? seconds
-- Recast Time: 20 seconds
-- -20% Attack for 30 seconds
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local params = {}
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    params.effect = xi.effect.ATTACK_DOWN
    local resist = applyResistance(caster, target, spell, params)
    local duration = 30 * resist
    local power = 20

    if (resist > 0.5) then -- Do it!
        if (target:addStatusEffect(params.effect, power, 3, duration)) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return params.effect
end

return spell_object