-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Citipati
-----------------------------------
local ID = zones[xi.zone.ATTOHWA_CHASM]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.CITIPATI - 7] = ID.mob.CITIPATI, -- -328.973 -12.876 67.481
    [ID.mob.CITIPATI - 4] = ID.mob.CITIPATI, -- -398.931 -4.536 79.640
    [ID.mob.CITIPATI - 1] = ID.mob.CITIPATI, -- -381.284 -9.233 40.054
}

entity.spawnPoints =
{
    { x = -364.014, y = -4.634,  z = -2.627 },
    { x = -328.973, y = -12.876, z = 67.481 },
    { x = -398.931, y = -4.536,  z = 79.640 },
    { x = -381.284, y = -9.233,  z = 40.054 },
}

entity.onMobRoam = function(mob)
    -- Since DisallowRespawn() doesn't care about SPAWNTYPE_NIGHT we have to get creative
    local totd = VanadielTOTD()
    if totd ~= xi.time.NIGHT and totd ~= xi.time.MIDNIGHT then
        mob:setLocalVar('doNotInvokeCooldown', 1)
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 278)
end

return entity
