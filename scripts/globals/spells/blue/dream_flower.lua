-----------------------------------
-- Spell: Dream Flower
-- Puts all enemies within range to sleep
-- Spell cost: 68 MP
-- Monster Type: Plantoids
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 3
-- Stat Bonus: HP+5 MP+5 CHR+2
-- Level: 87
-- Casting Time: Casting Time: 2.5 seconds
-- Recast Time: Recast Time: 45 seconds
-- Duration: 90~120 seconds
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local typeEffect = xi.effect.SLEEP_II
    local params = {}
    params.diff = nil
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    params.bonus = 0
    params.effect = typeEffect
    local resist = applyResistanceEffect(caster, target, spell, params)
    local duration = 120

    if (resist > 0.5) then -- Do it!
        if (target:addStatusEffect(typeEffect, 1, 3, duration * resist)) then
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
