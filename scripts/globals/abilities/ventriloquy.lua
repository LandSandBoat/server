-----------------------------------
-- Ability: Ventriloquy
-- Swaps the enmity of master and automaton for target.
-- Obtained: Puppetmaster Level 75
-- Recast Time: 1:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/pets")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    local pet = player:getPet()

    if not pet then
        return xi.msg.basic.REQUIRES_A_PET, 0
    elseif not pet:isAutomaton() then
        return xi.msg.basic.NO_EFFECT_ON_PET, 0
    end

    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    local pet = player:getPet()

    if pet then
        local enmitylist            = target:getEnmityList()
        local playerfound, petfound = false, false

        for k, v in pairs(enmitylist) do
            if v.entity:getTargID() == player:getTargID() then
                playerfound = true
            elseif v.entity:getTargID() == pet:getTargID() then
                petfound = true
            end
        end

        if playerfound and petfound then
            local bonus             = (player:getMerit(xi.merit.VENTRILOQUY) - 5) / 100
            local playerCE          = target:getCE(player)
            local playerVE          = target:getVE(player)
            local petCE             = target:getCE(pet)
            local petVE             = target:getVE(pet)
            local playerEnmityBonus = 1
            local petEnmityBonus    = 1

            if
                target:getTarget():getTargID() == player:getTargID() or
                ((playerCE + playerVE) >= (petCE + petVE) and target:getTarget():getTargID() ~= pet:getTargID())
            then
                playerEnmityBonus = playerEnmityBonus + bonus
                petEnmityBonus    = petEnmityBonus - bonus
            else
                playerEnmityBonus = playerEnmityBonus - bonus
                petEnmityBonus    = petEnmityBonus + bonus
            end

            target:setCE(player, petCE * petEnmityBonus)
            target:setVE(player, petVE * petEnmityBonus)
            target:setCE(pet, playerCE * playerEnmityBonus)
            target:setVE(pet, playerVE * playerEnmityBonus)
        end
    end
end

return abilityObject
