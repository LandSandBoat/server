-----------------------------------
-- Ability: Scavenge
-- Searches the ground around user for items.
-- Obtained: Ranger Level 10
-- Recast Time: 3:00
-- Duration: Instant
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability, action)
    -- RNG AF2 quest check
    local fireAndBrimstoneCS = player:getCharVar('fireAndBrimstone')
    local oldEarring         = 1113 -- TODO: Use items file.

    if
        player:getZoneID() == 151 and fireAndBrimstoneCS == 5 and-- zone + quest match
        not player:hasItem(oldEarring) and -- make sure player doesn't already have the earring
        player:getYPos() > -43 and player:getYPos() < -38 and -- Y match
        player:getXPos() > -85 and player:getXPos() < -73 and -- X match
        player:getZPos() > -85 and player:getZPos() < -75 and -- Z match
        math.random(1, 100) <= 50
    then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED, oldEarring)
            return
        else
            player:addItem(oldEarring)
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, oldEarring)
        end

    else
        local bonuses        = (player:getMod(xi.mod.SCAVENGE_EFFECT) + player:getMerit(xi.merit.SCAVENGE_EFFECT)) / 100
        local arrowsToReturn = math.floor(math.floor(player:getLocalVar('ArrowsUsed') % 10000) * (player:getMainLvl() / 200 + bonuses))
        local playerID       = target:getID()

        if arrowsToReturn == 0 then
            action:messageID(playerID, 139)
        else
            if arrowsToReturn > 99 then
                arrowsToReturn = 99
            end

            local arrowID = math.floor(player:getLocalVar('ArrowsUsed') / 10000)
            player:addItem(arrowID, arrowsToReturn)

            if arrowsToReturn == 1 then
                action:messageID(playerID, 140)
            else
                action:messageID(playerID, 674)
                action:additionalEffect(playerID, 1)
                action:addEffectParam(playerID, arrowsToReturn)
            end

            player:setLocalVar('ArrowsUsed', 0)
            return arrowID
        end
    end
end

return abilityObject
