-----------------------------------
-- Area: The Sanctuary of Zi'Tah
--  Mob: Myxomycete
-- Note: PH for Noble Mold
-----------------------------------
local ID = require("scripts/zones/The_Sanctuary_of_ZiTah/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    if mob:getID() == ID.mob.NOBLE_MOLD_PH then
        mob:setLocalVar("timeToMorph", os.time() + math.random(43200, 57600)) -- 12:00:00 to 16:00:00
    end
end

entity.onMobDisengage = function(mob)
    if mob:getID() == ID.mob.NOBLE_MOLD_PH then
        mob:setLocalVar("timeToMorph", os.time() + math.random(43200, 57600)) -- 12:00:00 to 16:00:00
    end
end

entity.onMobRoam = function(mob)
    -- Noble Mold PH has been left alone for 12-16 hours and it is rainy
    if
        mob:getID() == ID.mob.NOBLE_MOLD_PH and
        os.time() > mob:getLocalVar("timeToMorph") and
        (mob:getWeather() == xi.weather.RAIN or
        mob:getWeather() == xi.weather.SQUALL)
    then
        DisallowRespawn(ID.mob.NOBLE_MOLD_PH, true)
        DespawnMob(ID.mob.NOBLE_MOLD_PH)
        DisallowRespawn(ID.mob.NOBLE_MOLD, false)
        local pos = mob:getPos()
        SpawnMob(ID.mob.NOBLE_MOLD):setPos(pos.x, pos.y, pos.z, pos.rot)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 115, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 116, 2, xi.regime.type.FIELDS)
end

return entity
