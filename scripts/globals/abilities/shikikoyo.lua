-----------------------------------
-- Ability: Shikikoyo
-- Share TP above 1000 with a party member.
-- Obtained: Samurai Level 75
-- Recast Time: 5:00
-- Duration: Instant
-- Target: Party member, cannot target self.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if (player:getID() == target:getID()) then
        return xi.msg.basic.CANNOT_PERFORM_TARG, 0
    elseif (player:getTP() < 1000) then
        return xi.msg.basic.NOT_ENOUGH_TP, 0
    else
        return 0, 0
    end
end

ability_object.onUseAbility = function(player, target, ability)
    local pTP = (player:getTP() - 1000) * (1 + ((player:getMerit(xi.merit.SHIKIKOYO) - 12) / 100))
    pTP = utils.clamp(pTP, 0, 3000 - target:getTP())

    player:setTP(1000)
    target:setTP(target:getTP() + pTP)

    return pTP
end

return ability_object
