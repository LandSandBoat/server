-----------------------------------
-- Spell: Alexander
-- Summons Alexander to fight by your side
-----------------------------------
require("scripts/globals/summon")
require("scripts/globals/pets")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    if not caster:canUseMisc(xi.zoneMisc.PET) then
        return xi.msg.basic.CANT_BE_USED_IN_AREA
    elseif not caster:hasStatusEffect(xi.effect.ASTRAL_FLOW) then
        return xi.msg.basic.MAGIC_MUST_ASTRAL_FLOW
    elseif caster:hasPet() then
        return xi.msg.basic.ALREADY_HAS_A_PET
    elseif caster:getObjType() == xi.objType.PC then
        return xi.summon.avatarMiniFightCheck(caster)
    end

    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    caster:spawnPet(xi.pet.id.ALEXANDER)
    return 0
end

return spellObject
