-----------------------------------
-- Ability: Heel
-- Commands the pet to cease attacking and return to you.
-- Obtained: Beastmaster Level 10
-- Recast Time: 5 seconds
-- Duration: N/A
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    if player:getPet() == nil then
        return xi.msg.basic.REQUIRES_A_PET, 0
    end

    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    local pet = player:getPet()

    if pet:hasStatusEffect(xi.effect.HEALING) then
        pet:delStatusEffect(xi.effect.HEALING)
    end

    player:petRetreat()
end

return abilityObject
