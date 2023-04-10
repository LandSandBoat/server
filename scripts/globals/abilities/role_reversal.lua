-----------------------------------
-- Ability: Role Reversal
-- Swaps Master's current HP with Automaton's current HP.
-- Obtained: Puppetmaster Level 75
-- Recast Time: 2:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/pets")
require("scripts/globals/status")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    local pet = player:getPet()

    if not pet then
        return xi.msg.basic.REQUIRES_A_PET, 0
    elseif not pet:isAutomaton() then
        return xi.msg.basic.NO_EFFECT_ON_PET, 0
    else
        return 0, 0
    end
end

abilityObject.onUseAbility = function(player, target, ability)
    local pet = player:getPet()

    if pet then
        local bonus    = 1 + (player:getMerit(xi.merit.ROLE_REVERSAL) - 5) / 100
        local playerHP = player:getHP()
        local petHP    = pet:getHP()

        pet:setHP(math.max(playerHP * bonus, 1))
        player:setHP(math.max(petHP * bonus, 1))
    end
end

return abilityObject
