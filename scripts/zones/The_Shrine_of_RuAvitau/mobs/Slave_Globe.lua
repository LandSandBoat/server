-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Slave Globe
-----------------------------------
local ID = zones[xi.zone.THE_SHRINE_OF_RUAVITAU]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    local mg = GetMobByID(ID.mob.MOTHER_GLOBE)

    if mg:getLocalVar('nextSlaveSpawnTime') == 0 then
        mg:setLocalVar('nextSlaveSpawnTime', os.time() + 30)
    end
end

return entity
