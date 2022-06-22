-----------------------------------
-- Ability: Super Jump
-- Performs a super jump.
-- Obtained: Dragoon Level 50
-- Recast Time: 3:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/job_utils/dragoon")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    local wyvern = player:getPet()

    xi.job_utils.dragoon.useSuperJump(player, target, ability)

<<<<<<< HEAD
<<<<<<< HEAD
    if wyvern ~= nil and player:getPetID() == xi.pet.id.WYVERN and wyvern:getHP() > 0 then
        wyvern:useJobAbility(xi.jobAbility.SUPER_CLIMB, wyvern)
=======
    if (wyvern ~= nil and wyvern:getHP() > 0) then
=======
    if (wyvern ~= nil and player:getPetID() == xi.pet.id.WYVERN and wyvern:getHP() > 0) then
<<<<<<< HEAD
>>>>>>> 329e836cae (Fix)
        wyvern:useJobAbility(652, wyvern)
>>>>>>> b8d0d1329e (Mob fixes)
=======
        wyvern:useJobAbility(xi.jobAbility.SUPER_CLIMB, wyvern)
>>>>>>> 21685b9611 (Update super_jump.lua)
    end
end

return ability_object
