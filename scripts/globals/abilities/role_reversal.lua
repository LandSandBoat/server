-----------------------------------
-- Ability: Role Reversal
-- Swaps Master's current HP with Automaton's current HP.
-- Obtained: Puppetmaster Level 75
-- Recast Time: 2:00
-- Duration: Instant
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/pets")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if not player:getPet() then
        return xi.msg.basic.REQUIRES_A_PET, 0
    elseif not player:getPetID() or not (player:getPetID() >= 69 and player:getPetID() <= 72) then
        return xi.msg.basic.NO_EFFECT_ON_PET, 0
    else
        return 0, 0
    end
end

ability_object.onUseAbility = function(player, target, ability)
    local pet = player:getPet()
    if pet then
        local bonus = 1 + (player:getMerit(xi.merit.ROLE_REVERSAL)-5)/100
        local playerHP = player:getHP()
        local petHP = pet:getHP()
        pet:setHP(math.max(playerHP * bonus, 1))
        player:setHP(math.max(petHP * bonus, 1))
    end
end

return ability_object
