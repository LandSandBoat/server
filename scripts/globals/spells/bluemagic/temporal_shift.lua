-----------------------------------
-- Spell: Temporal Shift
-- Enemies within range are temporarily prevented from acting
-- Spell cost: 48 MP
-- Monster Type: Luminians
-- Spell Type: Magical (Lightning)
-- Blue Magic Points: 5
-- Stat Bonus: HP+10, MP+15
-- Level: 73
-- Casting Time: 0.5 seconds
-- Recast Time: 120 seconds
-- Magic Bursts on: Impaction, Fragmentation, and Light
-- Combos: Attack Bonus
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
    local typeEffect = xi.effect.STUN
    -- local dINT = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local params = {}
    params.diff = nil
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    params.bonus = 0
    params.effect = xi.effect.STUN
    local resist = applyResistanceEffect(caster, target, spell, params)
    local duration = 5 * resist

    if (resist > 0.0625) then -- Do it!
        if (target:addStatusEffect(typeEffect, 2, 0, duration)) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return typeEffect
end

return spell_object
