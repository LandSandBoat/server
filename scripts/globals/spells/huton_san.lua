-----------------------------------
-- Spell: Huton: San
-----------------------------------
require("scripts/globals/magic_utils/spell_damage")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local duration = 15 + caster:getMerit(xi.merit.HUTON_EFFECT) -- T1 bonus debuff duration
    handleNinjutsuDebuff(caster, target, spell, 30, duration, xi.mod.ICE_RES)

    return xi.magic_utils.spell_damage.useDamageSpell(caster, target, spell)
end

return spell_object
