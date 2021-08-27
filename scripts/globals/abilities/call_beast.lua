-----------------------------------
-- Ability: Call Beast
-- Calls a beast to fight by your side.
-- Obtained: Beastmaster Level 23
-- Recast Time: 5:00
-- Duration: Dependent on jug pet used.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if player:getPet() ~= nil then
        return xi.msg.basic.ALREADY_HAS_A_PET, 0
    elseif not player:hasValidJugPetItem() then
        return xi.msg.basic.NO_JUG_PET_ITEM, 0
    elseif not player:canUseMisc(xi.zoneMisc.PET) then
        return xi.msg.basic.CANT_BE_USED_IN_AREA, 0
    else
        return 0, 0
    end
end

ability_object.onUseAbility = function(player, target, ability)
    xi.pet.spawnPet(player, player:getWeaponSubSkillType(xi.slot.AMMO))
    player:removeAmmo()
    -- Briefly put the recastId for READY/SIC (102) into a recast state to
    -- toggle charges accumulating. 102 is the shared recast id for all jug
    -- pet abilities and for SIC when using a charmed mob.
    -- see sql/abilities_charges and sql_abilities
    player:addRecast(xi.recast.ABILITY, 102, 1)
end

return ability_object
