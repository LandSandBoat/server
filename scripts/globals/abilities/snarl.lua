-----------------------------------
-- Ability: Snarl
-- Transfers hate to your pet. Only works on pets invoked with the "Call Beast" ability.
-- Obtained: Beastmaster Level 45
-- Recast Time: 30 seconds
-- Duration: N/A
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/pets")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if (player:getPet() == nil) then
        return tpz.msg.basic.REQUIRES_A_PET, 0
    else
        if ((player:getPet():getTarget() ~= nil) and (player:isJugPet())) then
            return 0, 0
        else
            return tpz.msg.basic.PET_CANNOT_DO_ACTION, 0
        end
    end
end

function onUseAbility(player, target, ability)
    player:transferEnmity(player:getPet(), 99, 11.5)
end
