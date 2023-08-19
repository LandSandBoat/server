-----------------------------------
-- Area: The Sanctuary of Zi'Tah
--  Mob: Myxomycete
-- Note: PH for Noble Mold
-----------------------------------
local ID = zones[xi.zone.THE_SANCTUARY_OF_ZITAH]
-----------------------------------
local entity = {}

entity.onMobRoam = function(mob)
    local weather = mob:getWeather()

    if weather == xi.weather.RAIN or weather == xi.weather.SQUALL then
        if xi.mob.phOnDespawn(mob, ID.mob.NOBLE_MOLD_PH, 100, math.random(43200, 57600), true) then -- 12 to 16 hours
            local p = mob:getPos()
            GetMobByID(ID.mob.NOBLE_MOLD):setSpawn(p.x, p.y, p.z, p.rot)
            DespawnMob(mob:getID())
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 115, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 116, 2, xi.regime.type.FIELDS)
end

return entity
