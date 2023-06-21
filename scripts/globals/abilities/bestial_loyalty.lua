-----------------------------------
-- Ability: Bestial Loyalty
-- Calls a beast to fight by your side without consuming bait
-- Obtained: Beastmaster Level 23
-- Recast Time: 20:00
-- Duration: Dependent on jug pet used.
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    if player:getPet() ~= nil then
        return xi.msg.basic.ALREADY_HAS_A_PET, 0
    elseif not player:hasValidJugPetItem() then
        return xi.msg.basic.NO_JUG_PET_ITEM, 0
    elseif not player:canUseMisc(xi.zoneMisc.PET) then
        return xi.msg.basic.CANT_BE_USED_IN_AREA, 0
    end

    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.pet.spawnPet(player, player:getWeaponSubSkillType(xi.slot.AMMO))
end

return abilityObject
