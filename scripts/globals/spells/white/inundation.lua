-----------------------------------
-- Spell: Inundation
-- Spell accuracy is most highly affected by Enfeebling Magic Skill, Magic Accuracy, and MND.
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/utils")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    target:addStatusEffect(xi.effect.INUNDATION, 1, 0, 300) --Inundated, 5min duration
    spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
    return xi.effect.INUNDATION
end

return spellObject
