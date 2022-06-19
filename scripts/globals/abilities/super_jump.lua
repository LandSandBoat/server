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

    if (wyvern ~= nil and player:getPetID() == xi.pet.id.WYVERN and wyvern:getHP() > 0) then
        wyvern:useJobAbility(652, wyvern)
    end
end

return ability_object
