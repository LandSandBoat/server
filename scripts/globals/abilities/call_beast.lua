-----------------------------------
-- Ability: Call Beast
-- Calls a beast to fight by your side.
-- Obtained: Beastmaster Level 23
-- Recast Time: 5:00
-- Duration: Dependent on jug pet used.
-----------------------------------
require("scripts/globals/common")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
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

function onUseAbility(player, target, ability)
    tpz.pet.spawnPet(player, player:getWeaponSubSkillType(tpz.slot.AMMO))
    player:removeAmmo()
    -- Briefly put the recastId for READY/SIC (102) into a recast state to 
    -- toggle charges accumulating. 102 is the shared recast id for all jug
    -- pet abilities and for SIC when using a charmed mob.
    -- see sql/abilities_charges and sql_abilities
    player:addRecast(tpz.recast.ABILITY, 102, 1)
end
