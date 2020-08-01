-----------------------------------------
-- Spell: Threnody - tpz.mod.WATERRES
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    return handleThrenody(caster, target, spell, 50, 60, tpz.mod.WATERRES)
end
