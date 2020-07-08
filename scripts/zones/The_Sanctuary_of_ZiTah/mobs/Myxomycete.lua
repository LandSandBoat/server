-----------------------------------
-- Area: The Sanctuary of Zi'Tah
--  Mob: Myxomycete
-- Note: PH for Noble Mold
-----------------------------------
local ID = require("scripts/zones/The_Sanctuary_of_ZiTah/IDs")
require("scripts/globals/regimes")
require("scripts/globals/world")
require("scripts/globals/mobs")
-----------------------------------

function onMobRoam(mob)
    local weather = mob:getWeather()

    if weather == tpz.weather.RAIN or weather == tpz.weather.SQUALL then
        if tpz.mob.phOnDespawn(mob, ID.mob.NOBLE_MOLD_PH, 100, math.random(43200, 57600), true) then -- 12 to 16 hours
            local p = mob:getPos()
            GetMobByID(ID.mob.NOBLE_MOLD):setSpawn(p.x, p.y, p.z, p.rot)
            DespawnMob(mob:getID())
        end
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 115, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 116, 2, tpz.regime.type.FIELDS)
end
