-----------------------------------
-- Area: Castle Oztroja (151)
--   NM: Yagudo Avatar
-- Note: PH for Tzee Xicu the Manifest
-- TODO: messages should be zone-wide
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  -96.516, y = -73.255, z =  97.807 },
    { x =  -98.281, y = -72.000, z =  94.926 },
    { x = -104.318, y = -72.000, z =  95.202 },
    { x =  -99.952, y = -72.000, z =  91.543 },
    { x = -102.311, y = -72.000, z =  91.883 },
    { x = -107.448, y = -72.000, z =  91.881 },
    { x =  -97.150, y = -72.000, z =  97.036 },
    { x =  -99.972, y = -72.000, z =  96.829 },
    { x =  -98.458, y = -72.000, z =  91.278 },
    { x =  -96.798, y = -72.000, z =  93.610 },
    { x =  -97.209, y = -72.000, z =  93.699 },
    { x =  -92.300, y = -72.000, z =  93.777 },
    { x =  -96.712, y = -72.000, z =  90.577 },
    { x =  -97.927, y = -72.000, z =  89.527 },
    { x =  -99.824, y = -72.000, z =  92.164 },
    { x =  -95.570, y = -72.000, z =  97.696 },
    { x = -101.309, y = -72.000, z =  91.051 },
    { x =  -93.515, y = -72.000, z =  94.398 },
    { x =  -99.890, y = -72.000, z =  98.849 },
    { x = -108.291, y = -72.000, z =  97.696 },
    { x = -105.484, y = -72.000, z =  95.887 },
    { x = -105.113, y = -72.000, z =  92.358 },
    { x = -106.726, y = -72.000, z =  97.639 },
    { x =  -99.014, y = -72.000, z =  98.486 },
    { x =  -96.157, y = -72.000, z =  89.671 },
    { x =  -97.370, y = -72.000, z =  96.756 },
    { x = -108.852, y = -72.000, z =  92.674 },
    { x = -104.051, y = -72.000, z =  96.520 },
    { x = -103.763, y = -72.000, z =  90.407 },
    { x =  -97.662, y = -72.000, z =  89.326 },
    { x =  -96.052, y = -72.000, z =  97.626 },
    { x = -101.619, y = -72.000, z =  89.486 },
    { x =  -97.521, y = -72.000, z =  99.011 },
    { x = -103.817, y = -72.000, z =  97.466 },
    { x = -104.539, y = -72.000, z =  96.002 },
    { x = -101.679, y = -72.000, z =  99.876 },
    { x =  -99.505, y = -72.000, z =  89.141 },
    { x =  -94.950, y = -72.000, z =  96.423 },
    { x = -105.111, y = -72.000, z =  91.326 },
    { x = -101.140, y = -72.000, z =  99.131 },
    { x =  -94.285, y = -72.000, z =  94.315 },
    { x =  -94.645, y = -72.000, z =  91.236 },
    { x = -105.598, y = -72.000, z =  93.795 },
    { x =  -98.587, y = -72.000, z =  98.951 },
    { x = -104.148, y = -72.000, z =  95.408 },
    { x = -100.273, y = -72.000, z =  93.742 },
    { x =  -97.864, y = -72.000, z =  95.217 },
    { x =  -99.029, y = -72.000, z =  99.571 },
    { x =  -98.356, y = -72.000, z =  91.743 },
    { x = -101.428, y = -72.000, z =  96.497 }
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Yagudos_Elemental')
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(900, 10800))
end

entity.onMobEngage = function(mob, target)
    mob:showText(mob, ID.text.YAGUDO_AVATAR_ENGAGE)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        mob:showText(mob, ID.text.YAGUDO_AVATAR_DEATH)
    end
end

entity.onMobDespawn = function(mob)
    local mobId = mob:getID()

    -- The quest version of this NM doesn't respawn or count toward hq nm.
    if mobId ~= ID.mob.YAGUDO_AVATAR then
        return
    end

     -- Respawn logic.
    local hqId        = mobId + 3
    local timeOfDeath = GetServerVariable('[POP]Tzee_Xicu_the_Manifest')
    local kills       = GetServerVariable('[PH]Tzee_Xicu_the_Manifest') + 1
    local popNow      = kills >= 7 or (kills >= 2 and math.random(1, 100) <= 20)
    local respawnTime = 75600 + 1800 * math.random(1, 6)

    if GetSystemTime() > timeOfDeath and popNow then
        DisallowRespawn(mobId, true)
        DisallowRespawn(hqId, false)
        xi.mob.updateNMSpawnPoint(hqId)
        GetMobByID(hqId):setRespawnTime(respawnTime)
    else
        xi.mob.updateNMSpawnPoint(mobId)
        mob:setRespawnTime(respawnTime)
        SetServerVariable('[PH]Tzee_Xicu_the_Manifest', kills)
    end
end

return entity
