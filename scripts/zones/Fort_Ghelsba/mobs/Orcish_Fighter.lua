-----------------------------------
-- Area: Fort Ghelsba
--  Mob: Orcish Fighter
-----------------------------------
local ID = zones[xi.zone.FORT_GHELSBA]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    if mob:getID() == (ID.mob.ORCISH_PANZER + 1) then
        DisallowRespawn(ID.mob.ORCISH_PANZER, false)
        GetMobByID(ID.mob.ORCISH_PANZER):setRespawnTime(math.random(3600, 4200)) -- 60 to 70 min
    end
end

return entity
