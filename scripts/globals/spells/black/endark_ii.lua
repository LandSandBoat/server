-----------------------------------
-- Spell: Endark II
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local effect     = xi.effect.ENDARK
    local magicskill = target:getSkillLevel(xi.skill.DARK_MAGIC)
    local potency    = math.floor((math.floor((magicskill + 21) / 13) + 5) * 2.5)
    local duration   = calculateDuration(180, spell:getSkillType(), spell:getSpellGroup(), caster, target)

    if target:addStatusEffect(effect, potency, 0, duration) then
        spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return effect
end

return spell_object
