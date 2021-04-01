-----------------------------------
-- Spell: Geo-Poison
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/geo")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    if caster:getPet() ~= nil then
        return xi.msg.basic.LUOPAN_ALREADY_PLACED
    elseif not caster:canUseMisc(xi.zoneMisc.PET) then
        return xi.msg.basic.CANT_BE_USED_IN_AREA
    else
        return 0
    end
end

spell_object.onSpellCast = function(caster, target, spell)
    local geo_skill = caster:getCharSkillLevel(xi.skill.GEOMANCY)
    local power = (geo_skill / 30) / 10
    if power < 1 then
        power = 1
    end

    -- NOTE: In the future the model ID (2863) will not be passed through here!
    xi.geo.spawnLuopan(caster, target, 2863, xi.effect.GEO_POISON, power, xi.auraTarget.ENEMIES, spell)
end

return spell_object
