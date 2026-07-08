-----------------------------------
-- Area: Arrapago Reef
--  NM: Lamia No.19
-- TODO: On retail, she walks randomly in her spawn zones rather than using set points. The set points are used here to avoid
--       complications with pathfinding and her long roam range.
-- TODO: Get more data on the reveal chance rate. 80% is an estimate based on current captures.
-- TODO: Get more data on the maximum respawn time. Minimum is 1 hour based on current captures, but more data is needed.
-----------------------------------
mixins = { require('scripts/mixins/weapon_break') }
-----------------------------------
-- Patrol zones. She spawns in one at random, starts on its first point, walks the list to the end, then back up, and repeats
local patrolZones =
{
    -- Zone 1
    [1] =
    {
        [ 1] = { x = -140.3979, y = -7.5625, z = 129.6947 },
        [ 2] = { x = -151.5618, y = -7.5669, z = 133.4263 },
        [ 3] = { x = -159.6965, y = -4.0674, z = 142.4664 },
        [ 4] = { x = -147.8239, y = -3.9370, z = 143.8264 },
        [ 5] = { x = -132.7979, y = -4.1487, z = 142.3289 },
        [ 6] = { x = -116.7645, y = -5.6650, z = 138.4146 },
        [ 7] = { x = -106.3411, y = -3.6548, z = 149.6426 },
        [ 8] = { x =  -95.9528, y = -7.0264, z = 157.3188 },
        [ 9] = { x =  -97.9981, y = -8.2839, z = 177.5508 },
        [10] = { x =  -95.9604, y = -6.5235, z = 194.4670 },
        [11] = { x =  -97.5012, y = -6.2962, z = 209.2726 },
        [12] = { x =  -84.0119, y = -6.6560, z = 216.9704 },
    },

    -- Zone 2
    [2] =
    {
        [ 1] = { x = -70.4526, y = -3.4229, z = 225.8736 },
        [ 2] = { x = -55.8334, y = -6.8534, z = 234.8286 },
        [ 3] = { x = -52.0121, y = -7.6663, z = 252.0792 },
        [ 4] = { x = -36.6158, y = -7.1406, z = 255.2419 },
        [ 5] = { x = -18.6769, y = -4.2378, z = 257.9763 },
        [ 6] = { x = -23.2517, y = -6.7339, z = 240.1379 },
        [ 7] = { x = -29.7112, y = -7.3039, z = 226.7537 },
        [ 8] = { x = -23.0620, y = -8.6800, z = 213.3530 },
        [ 9] = { x = -27.1148, y = -8.1091, z = 204.9024 },
        [10] = { x =  -9.3409, y = -4.1911, z = 209.8858 },
        [11] = { x =  -6.8611, y = -3.6151, z = 227.8160 },
    },

    -- Zone 3
    [3] =
    {
        [1] = { x = 24.1552, y = -4.3124, z = 222.5897 },
        [2] = { x = 29.0236, y = -7.6649, z = 211.4547 },
        [3] = { x = 18.9880, y = -4.6938, z = 199.3556 },
        [4] = { x =  7.5865, y = -3.9338, z = 190.0146 },
        [5] = { x = 23.4894, y = -8.4546, z = 181.0779 },
        [6] = { x = 26.4053, y = -7.4731, z = 163.9737 },
        [7] = { x = 16.8353, y = -7.3900, z = 155.6682 },
        [8] = { x =  0.1742, y = -1.9985, z = 159.1774 },
    },
}

---@type TMobEntity
local entity = {}

-- Hide her and (re)start the patrol from the first point of a zone. Pass a zoneIndex to keep her in the zone she just returned to; omit it on first spawn to pick a zone at random
local function goDormant(mob, zoneIndex)
    mob:clearPath()

    zoneIndex = zoneIndex or math.randomInt(1, #patrolZones)

    mob:setLocalVar('patrolZone', zoneIndex)
    mob:setLocalVar('state', 0)
    mob:setLocalVar('appearTime', 0)
    mob:setLocalVar('wpIndex', 1) -- Current patrol point (She starts at point 1)
    mob:setLocalVar('wpDirection', 0)
    mob:setLocalVar('nextMoveTime', GetSystemTime() + 25)

    mob:setStatus(xi.status.INVISIBLE)
    mob:setMagicCastingEnabled(false)
    mob:hideHP(true)
    mob:hideName(true)
    mob:setUntargetable(true)
    mob:setAggressive(false)
    mob:setTrueDetection(false)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 0)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)

    -- Start on the zone's first point; movement is driven in onMobRoam
    local point = patrolZones[zoneIndex][1]
    mob:setPos(point.x, point.y, point.z) -- Teleports back to first point in her starting patrol zone.
end

-- Disengage/give up: enter the patrol-point network at the nearest point and walk it back home
local function startReturningHome(mob)
    -- The fight is over. Despawn adds.
    local mobId = mob:getID()
    DespawnMob(mobId + 1)
    DespawnMob(mobId + 2)

    -- Get the closest point index.
    local bestZoneIndex  = 1
    local bestPointIndex = 1
    local bestDistance   = 1000000000

    for zoneIndex = 1, #patrolZones do
        local zonePoints = patrolZones[zoneIndex]
        for pointIndex = 1, #zonePoints do
            local point    = patrolZones[zoneIndex][pointIndex]
            local distance = mob:checkDistance(point.x, point.y, point.z)
            if distance <= bestDistance then
                bestZoneIndex  = zoneIndex
                bestPointIndex = pointIndex
                bestDistance   = distance
            end
        end
    end

    -- Setup mob.
    mob:setLocalVar('state', 2)
    mob:setLocalVar('returnZoneIndex', bestZoneIndex)
    mob:setLocalVar('returnPointIndex', bestPointIndex)
    mob:setLocalVar('returnPauseUntil', 0)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:clearPath()

    local returnPoint = patrolZones[bestZoneIndex][bestPointIndex]
    mob:pathThrough({ returnPoint.x, returnPoint.y, returnPoint.z })
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    -- Don't let the engine drag her back to her DB spawn point (with WALLHACK) while she patrols far from it
    mob:setMobMod(xi.mobMod.DONT_ROAM_HOME, 1)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.POWER_MULTIPLIER_SPELL, 20)

    goDormant(mob)
end

entity.onMobRoam = function(mob)
    local currentTime = GetSystemTime()
    local state       = mob:getLocalVar('state')

    -- Dormant and invisible: Walk the patrol and watch for a nearby death.
    if state == 0 then
        if currentTime < mob:getLocalVar('nextMoveTime') then
            return
        end

        local pointTable = patrolZones[mob:getLocalVar('patrolZone')]
        local pointIndex = mob:getLocalVar('wpIndex')
        local point      = pointTable[pointIndex]

        -- Early return: Not at destiny yet.
        if mob:checkDistance(point.x, point.y, point.z) > 3 then
            return
        end

        -- At destiny. Choose next point to path to.
        local pathDirection = mob:getLocalVar('wpDirection')

        if pathDirection == 0 then
            if pointIndex >= #pointTable then
                pathDirection = 1 -- Reached the end; Turn around.
            end
        else
            if pointIndex <= 1 then
                pathDirection = 0 -- Reached the end; Turn around.
            end
        end

        pointIndex = pointIndex + (pathDirection == 0 and 1 or -1)

        mob:setLocalVar('wpIndex', pointIndex)
        mob:setLocalVar('wpDirection', pathDirection)
        mob:setLocalVar('nextMoveTime', currentTime + 25)

        local nextPoint = pointTable[pointIndex]
        mob:pathThrough({ nextPoint.x, nextPoint.y, nextPoint.z })

    -- Revealed but never engaged: after the idle timer she gives up and walks home
    elseif state == 1 then
        if currentTime >= mob:getLocalVar('appearTime') + 120 then -- 2 minutes
            startReturningHome(mob)
        end

    -- Returning: Walk the patrol-point network back to her zone's first point, pausing briefly at each, then re-hide.
    elseif state == 2 then
        local zoneTable  = patrolZones[mob:getLocalVar('returnZoneIndex')]
        local pointIndex = mob:getLocalVar('returnPointIndex')
        local point      = zoneTable[pointIndex]

        -- Reached target point.
        if mob:checkDistance(point.x, point.y, point.z) <= 3 then
            local pauseUntil = mob:getLocalVar('returnPauseUntil')
            -- Can't move: Wait ~3s (a tick) before moving on.
            if pauseUntil == 0 then
                mob:setLocalVar('returnPauseUntil', currentTime + 3)

            -- Can move. So move.
            elseif currentTime >= pauseUntil then
                mob:setLocalVar('returnPauseUntil', 0)

                -- At begining of a patrol zone. Go dormant.
                if pointIndex == 1 then
                    goDormant(mob, mob:getLocalVar('patrolZone'))

                -- Not at begining of a patrol zone. Path to next point.
                else
                    mob:setLocalVar('returnPointIndex', pointIndex - 1)

                    local nextPoint = zoneTable[pointIndex - 1]
                    mob:pathThrough({ nextPoint.x, nextPoint.y, nextPoint.z })
                end
            end

        -- Path interrupted; Resume.
        elseif not mob:isFollowingPath() then
            mob:pathThrough({ point.x, point.y, point.z })
        end
    end
end

entity.onMobEngage = function(mob, target)
    -- She was holding position: let her move now that she fights
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMagicCastingEnabled(true)

    -- Summon two Lamia's Skeleton next to her.
    local mobId = mob:getID()
    local x     = mob:getXPos()
    local y     = mob:getYPos()
    local z     = mob:getZPos()

    GetMobByID(mobId + 1):setSpawn(x + 2, y, z)
    GetMobByID(mobId + 2):setSpawn(x - 2, y, z)
    SpawnMob(mobId + 1):updateEnmity(target)
    SpawnMob(mobId + 2):updateEnmity(target)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.SLEEPGA_II,  target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,    2, 100 },
        [ 2] = { xi.magic.spell.BLIND,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BLINDNESS,  0, 100 },
        [ 3] = { xi.magic.spell.ASPIR,       target, false, xi.action.type.DRAIN_MP,             nil,                  0, 100 },
        [ 4] = { xi.magic.spell.STONE_IV,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [ 5] = { xi.magic.spell.BIO_II,      target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIO,        4, 100 },
        [ 6] = { xi.magic.spell.ICE_SPIKES,  mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.ICE_SPIKES, 0, 100 },
        [ 7] = { xi.magic.spell.BIND,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIND,       0, 100 },
        [ 8] = { xi.magic.spell.FIRE_IV,     target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [ 9] = { xi.magic.spell.POISONGA_II, target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.POISON,     0, 100 },
        [10] = { xi.magic.spell.SLEEPGA,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,    1, 100 },
        [11] = { xi.magic.spell.FLOOD,       target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [12] = { xi.magic.spell.WATERGA_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [13] = { xi.magic.spell.AERO_IV,     target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [14] = { xi.magic.spell.FIRAGA_III,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [15] = { xi.magic.spell.WATER_IV,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [16] = { xi.magic.spell.BLIZZARD_IV, target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobDisengage = function(mob)
    -- Combat ended (the player died fighting her, or she lost her target). She walks back along her zone's points; arrival is handled in onMobRoam
    mob:setMagicCastingEnabled(false)
    startReturningHome(mob)
end

entity.onMobDespawn = function(mob)
    -- She is never despawned by script, so this only runs when she is killed. Take any summoned skeletons with her and respawn her in 1-3 hours
    local mobId = mob:getID()
    DespawnMob(mobId + 1)
    DespawnMob(mobId + 2)

    mob:setRespawnTime(math.randomInt(3600, 10800)) -- respawn in 1-3 hours
end

return entity
