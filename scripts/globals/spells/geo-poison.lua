-----------------------------------
-- Spell: Geo-Poison
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/geo")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    if caster:getPet() ~= nil then
        return tpz.msg.basic.LUOPAN_ALREADY_PLACED
    elseif not caster:canUseMisc(tpz.zoneMisc.PET) then
        return tpz.msg.basic.CANT_BE_USED_IN_AREA
    else
        return 0
    end
end

spell_object.onSpellCast = function(caster, target, spell)
    local geo_skill = caster:getCharSkillLevel(tpz.skill.GEOMANCY)
    local power = (geo_skill / 30) / 10
    if power < 1 then
        power = 1
    end

    -- NOTE: In the future the model ID (2863) will not be passed through here!
    tpz.geo.spawnLuopan(caster, target, 2863, tpz.effect.GEO_POISON, power, tpz.auraTarget.ENEMIES, spell)
end

return spell_object
