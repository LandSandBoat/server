-----------------------------------
--  MOB: Psycheflayer
-- Area: Nyzul Isle
-- Info: Specified Mob Group and Eliminate all Group
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.nyzul.specifiedEnemySet(mob)

    -- There was a mob pool check for 8072 here but that doesn't exist anymore so it was removed.
    -- If I had to guess it was for Nyzul Isle and is now obsolete?
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.specifiedEnemyKill(mob)

        if mob:getID() >= 17092974 then
            xi.nyzul.specifiedGroupKill(mob)
        end
    end
end

return entity
