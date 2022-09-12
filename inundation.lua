-----------------------------------
-- Spell: Inundation
-- Spell accuracy is most highly affected by Enfeebling Magic Skill, Magic Accuracy, and MND.
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    target:addStatusEffect(xi.effect.INUNDATION, 1, 0, 300) --Inundated, 5min duration
	spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
    return xi.effect.INUNDATION
end

return spell_object
