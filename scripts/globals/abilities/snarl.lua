-----------------------------------
-- Ability: Snarl
-- Transfers hate to your pet. Only works on pets invoked with the "Call Beast" ability.
-- Obtained: Beastmaster Level 45
-- Recast Time: 30 seconds
-- Duration: N/A
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/pets")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    if player:getPet() == nil then
        return xi.msg.basic.REQUIRES_A_PET, 0
    else
        if player:getPet():getTarget() ~= nil and player:isJugPet() then
            return 0, 0
        else
            return xi.msg.basic.PET_CANNOT_DO_ACTION, 0
        end
    end
end

abilityObject.onUseAbility = function(player, target, ability)
    player:transferEnmity(player:getPet(), 99, 11.5)
end

return abilityObject
