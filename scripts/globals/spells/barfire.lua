-----------------------------------------
-- Spell: BARFIRE
-----------------------------------------
require("scripts/globals/spells/barspell")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    return applyBarspell(tpz.effect.BARFIRE, caster, target, spell)
end
