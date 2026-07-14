-----------------------------------
-- func: naga
-- desc: POC for Domain Invasion and fenced content in general.
--       Sets up the fence in Escha - RuAun and spawns Naga Raja.
--       Grants Confrontation to the user. Rerun to teardown.
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 5,
    parameters = '',
}

commandObj.onTrigger = function(player)
    if player:getZoneID() ~= xi.zone.ESCHA_RUAUN then
        player:printToPlayer('!naga can only be used in Escha - RuAun.')
        return
    end

    local naga = player:getZone():queryEntitiesByName('Naga_Raja')[1]
    if not naga then
        player:printToPlayer('Naga Raja not found in this zone.')
        return
    end

    -- Toggle off if already set up
    if player:hasStatusEffect(xi.effect.ELVORSEAL) then
        player:delStatusEffect(xi.effect.ELVORSEAL)
        player:objectiveUtility({ fence = { radius = 0.0 } }) -- radius 0 removes the fence
        if naga:isSpawned() then
            DespawnMob(naga:getID())
        end

        player:printToPlayer('Naga cleared.')
        return
    end

    if not naga:isSpawned() then
        SpawnMob(naga:getID())
    end

    local gateId = xi.domainInvasion.gateId
    local key = player:getID()
    -- Elvorseal carries the Confrontation flag so it inherits the same core isolation machinery as Confrontation.
    naga:addStatusEffect(xi.effect.ELVORSEAL, { power = key, subPower = gateId, origin = naga })
    player:addStatusEffect(xi.effect.ELVORSEAL, { power = key, subPower = gateId, origin = player })

    -- Set up the fence, about 25y radius around where Naga spawns.
    player:objectiveUtility({ fence = { pos = { x = naga:getXPos(), z = naga:getZPos() }, radius = 25.0, blue = true } })
    -- Teleport the player (this is where the retail NPC teleports you to)
    player:setPos(0, -43.775, -238, 191)

    player:printToPlayer('Naga Raja spawned.')
end

return commandObj
