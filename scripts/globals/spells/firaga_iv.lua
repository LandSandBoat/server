-----------------------------------
-- Spell: Firaga IV
-----------------------------------
require("scripts/globals/magic_utils/spell_damage")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    if caster:isPC() then -- Mob Only Spell.
        return xi.msg.basic.STATUS_PREVENTS
    else
        return 0
    end
end

spell_object.onSpellCast = function(caster, target, spell)
    return xi.magic_utils.spell_damage.useDamageSpell(caster, target, spell)
end

return spell_object
