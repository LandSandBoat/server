-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Slave Globe
-----------------------------------
local ID = zones[xi.zone.THE_SHRINE_OF_RUAVITAU]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    local mg = GetMobByID(ID.mob.MOTHER_GLOBE)

    if mg and mg:getLocalVar('nextSlaveSpawnTime') == 0 then
        mg:setLocalVar('nextSlaveSpawnTime', GetSystemTime() + 30)
    end
end

return entity
