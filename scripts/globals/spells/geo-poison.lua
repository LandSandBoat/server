-----------------------------------
-- Spell: Geo-Poison
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/job_utils/geomancer")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return xi.job_utils.geomancer.geoOnMagicCastingCheck(caster, target, spell)
end

spell_object.onSpellCast = function(caster, target, spell)
    local geo_skill = caster:getCharSkillLevel(xi.skill.GEOMANCY)
    local power = (geo_skill / 30) / 10
    if power < 1 then
        power = 1
    end

    -- NOTE: In the future the model ID (2863) will not be passed through here!
    xi.job_utils.geomancer.spawnLuopan(caster, target, 2863, xi.effect.GEO_POISON, power, xi.auraTarget.ENEMIES, spell)
end

return spell_object
