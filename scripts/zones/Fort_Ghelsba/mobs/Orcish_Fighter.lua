-----------------------------------
-- Area: Fort Ghelsba
--  Mob: Orcish Fighter
-----------------------------------
local ID = zones[xi.zone.FORT_GHELSBA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    if mob:getID() == (ID.mob.ORCISH_PANZER + 1) then
        DisallowRespawn(ID.mob.ORCISH_PANZER, false)
        GetMobByID(ID.mob.ORCISH_PANZER):setRespawnTime(math.randomInt(3600, 4200)) -- 60 to 70 min
    end
end

return entity
