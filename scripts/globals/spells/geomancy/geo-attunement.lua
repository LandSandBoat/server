-----------------------------------------
-- Spell: Geo-Attunement
-- Enhances magic evasion for party members within area of effect.
-----------------------------------------
require("scripts/globals/job_utils/geomancer")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.job_utils.geomancer.geoOnMagicCastingCheck(caster, target, spell)
end

spellObject.onSpellCast = function(caster, target, spell)
    xi.job_utils.geomancer.spawnLuopan(caster, target, spell)
end

return spellObject
