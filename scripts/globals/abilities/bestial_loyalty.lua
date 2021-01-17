-----------------------------------
-- Ability: Bestial Loyalty
-- Calls a beast to fight by your side without consuming bait
-- Obtained: Beastmaster Level 23
-- Recast Time: 20:00
-- Duration: Dependent on jug pet used.
-----------------------------------
require("scripts/globals/common")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if player:getPet() ~= nil then
        return tpz.msg.basic.ALREADY_HAS_A_PET, 0
    elseif not player:hasValidJugPetItem() then
        return tpz.msg.basic.NO_JUG_PET_ITEM, 0
    elseif not player:canUseMisc(tpz.zoneMisc.PET) then
        return tpz.msg.basic.CANT_BE_USED_IN_AREA, 0
    else
        return 0, 0
    end
end

ability_object.onUseAbility = function(player, target, ability)
    tpz.pet.spawnPet(player, player:getWeaponSubSkillType(tpz.slot.AMMO))
end

return ability_object
