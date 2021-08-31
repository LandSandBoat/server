-----------------------------------
-- Spell: Yawn
-- Puts all enemies within range to sleep
-- Spell cost: 55 MP
-- Monster Type: Birds
-- Spell Type: Magical (Light)
-- Blue Magic Points: 3
-- Stat Bonus: CHR+1, HP+5
-- Level: 64
-- Casting Time: 3 seconds
-- Recast Time: 60 seconds
-- Duration: 90 seconds
-- Magic Bursts on: Transfixion, Fusion, Light
-- Combos: Resist Sleep
-----------------------------------
require("scripts/settings/main")
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
    -- local dINT = (caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))
    local params = {}
    params.diff = nil
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    params.bonus = 0
    params.effect = typeEffect
    local resist = applyResistanceEffect(caster, target, spell, params)
    local duration = 90 * resist

    if (resist > 0.5) then -- Do it!
        if ((target:isFacing(caster))) then -- TODO: Apparently this check shouldn't exist for enemies using this spell? Need more info.
            if (target:addStatusEffect(typeEffect, 2, 0, duration)) then
                spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
            else
                spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
            end
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return typeEffect
end

return spell_object
