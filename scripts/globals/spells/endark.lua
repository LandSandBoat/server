-----------------------------------
-- Spell: Endark
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end


spell_object.onSpellCast = function(caster, target, spell)
    local effect = tpz.effect.ENDARK
    local magicskill = target:getSkillLevel(tpz.skill.DARK_MAGIC)
    local potency = (magicskill / 8) + 12.5

    if target:addStatusEffect(effect, potency, 0, 180) then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return effect
end

return spell_object
