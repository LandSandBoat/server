-----------------------------------
-- Spell: Geo-Regen
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
    local power = (geo_skill / 20) / 10
    if power < 1 then
        power = 1
    end

    -- NOTE: In the future the model ID (2856) will not be passed through here!
    xi.geo.spawnLuopan(caster, target, 2856, xi.effect.GEO_REGEN, power, xi.auraTarget.ALLIES, spell)
end

return spell_object
