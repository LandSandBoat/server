-----------------------------------
-- Spell: Shiva
-- Summons Shiva to fight by your side
-----------------------------------
require("scripts/globals/summon")
require("scripts/globals/pets")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    if (not caster:canUseMisc(tpz.zoneMisc.PET)) then
        return tpz.msg.basic.CANT_BE_USED_IN_AREA
    elseif (caster:hasPet()) then
        return tpz.msg.basic.ALREADY_HAS_A_PET
    elseif (caster:getObjType() == tpz.objType.PC) then
        return avatarMiniFightCheck(caster)
    end
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    tpz.pet.spawnPet(caster, tpz.pet.id.SHIVA)
    return 0
end

return spell_object
