-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Slave Globe
-----------------------------------
local ID = zones[xi.zone.THE_SHRINE_OF_RUAVITAU]
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addListener('DEATH', 'SLAVE_DEATH', function(mobArg, killer)
        -- Update slave follow order
        local followTarget = GetMobByID(ID.mob.MOTHER_GLOBE)
        for id = ID.mob.MOTHER_GLOBE + 1, ID.mob.MOTHER_GLOBE + 6 do
            local slaveGlobe = GetMobByID(id)

            if slaveGlobe then
                local action = slaveGlobe:getCurrentAction()

                if
                    followTarget and
                    action ~= xi.act.NONE and
                    action ~= xi.act.DEATH
                then
                    slaveGlobe:follow(followTarget, xi.followType.ROAM)
                    followTarget = slaveGlobe
                end
            end
        end
    end)
end

entity.onMobDeath = function(mob, player, optParams)
    local mg = GetMobByID(ID.mob.MOTHER_GLOBE)

    if mg and mg:getLocalVar('nextSlaveSpawnTime') == 0 then
        mg:setLocalVar('nextSlaveSpawnTime', os.time() + 30)
    end
end

return entity
