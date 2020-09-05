-----------------------------------
-- Ability: Ventriloquy
-- Swaps the enmity of master and automaton for target.
-- Obtained: Puppetmaster Level 75
-- Recast Time: 1:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/pets")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if not player:getPet() then
        return tpz.msg.basic.REQUIRES_A_PET, 0
    elseif not player:getPetID() or not (player:getPetID() >= 69 and player:getPetID() <= 72) then
        return tpz.msg.basic.NO_EFFECT_ON_PET, 0
    else
        return 0, 0
    end
end

function onUseAbility(player, target, ability)
    local pet = player:getPet()
    if pet then
        local enmitylist = target:getEnmityList()
        local playerfound, petfound = false, false
        for k, v in pairs(enmitylist) do
            if v.entity:getShortID() == player:getShortID() then
                playerfound = true
            elseif v.entity:getShortID() == pet:getShortID() then
                petfound = true
            end
        end

        if playerfound and petfound then
            local bonus = (player:getMerit(tpz.merit.VENTRILOQUY)-5)/100

            local playerCE = target:getCE(player)
            local playerVE = target:getVE(player)
            local petCE = target:getCE(pet)
            local petVE = target:getVE(pet)

            local playerEnmityBonus = 1
            local petEnmityBonus = 1
            if target:getTarget():getShortID() == player:getShortID() or ((playerCE + playerVE) >= (petCE + petVE) and target:getTarget():getShortID() ~= pet:getShortID()) then
                playerEnmityBonus = playerEnmityBonus + bonus
                petEnmityBonus = petEnmityBonus - bonus
            else
                playerEnmityBonus = playerEnmityBonus - bonus
                petEnmityBonus = petEnmityBonus + bonus
            end

            target:setCE(player, petCE * petEnmityBonus)
            target:setVE(player, petVE * petEnmityBonus)
            target:setCE(pet, playerCE * playerEnmityBonus)
            target:setVE(pet, playerVE * playerEnmityBonus)
        end
    end
end
