-----------------------------------
-- Spell: EarthSpirit
-- Summons EarthSpirit to fight by your side
-----------------------------------
require("scripts/globals/summon")
require("scripts/globals/bcnm")
require("scripts/globals/pets")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    local result = 0
    if (caster:hasPet()) then
        result = xi.msg.basic.ALREADY_HAS_A_PET
    elseif (not caster:canUseMisc(xi.zoneMisc.PET)) then
        result = xi.msg.basic.CANT_BE_USED_IN_AREA
    elseif (caster:getObjType() == xi.objType.PC) then
        result = avatarMiniFightCheck(caster)
    end
    return result
end

spell_object.onSpellCast = function(caster, target, spell)
    xi.pet.spawnPet(caster, xi.pet.id.EARTH_SPIRIT)
    return 0
end

return spell_object
