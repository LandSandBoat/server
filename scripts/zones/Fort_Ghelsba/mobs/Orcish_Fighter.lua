-----------------------------------
-- Area: Fort Ghelsba
--  Mob: Orcish Fighter
-----------------------------------
local ID = require("scripts/zones/Fort_Ghelsba/IDs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    if (mob:getID() == (ID.mob.ORCISH_PANZER + 1)) then
        DisallowRespawn(ID.mob.ORCISH_PANZER, false)
        if RESPAWN_SAVE_TIME then
            GetMobByID(ID.mob.ORCISH_PANZER):setRespawnTime(math.random(RESPAWN_SAVE_TIME_MIN, RESPAWN_SAVE_TIME_MAX))
        else
            GetMobByID(ID.mob.ORCISH_PANZER):setRespawnTime(math.random(3600, 4200)) -- 60 to 70 min
        end
    end
end

return entity
