-----------------------------------
-- Ability: Stay
-- Commands the Pet to stay in one place.
-- Obtained: Beastmaster Level 15
-- Recast Time: 5 seconds
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if (player:getPet() == nil) then
        return xi.msg.basic.REQUIRES_A_PET, 0
    end

    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability, action)
    local pet = player:getPet()

    if (not pet:hasPreventActionEffect()) then
        pet:addStatusEffectEx(xi.effect.HEALING, 0, 0, 10, 0)
        pet:setAnimation(0)
    end
end

return ability_object
