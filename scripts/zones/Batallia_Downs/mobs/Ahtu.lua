-----------------------------------
-- Area: Batallia Downs (105)
--  Mob: Ahtu
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)

    -- Set Ahtu's spawnpoint and respawn time (2-4 hours)
    UpdateNMSpawnPoint(mob:getID())
    if RESPAWN_SAVE_TIME then
        mob:setRespawnTime(math.random(RESPAWN_SAVE_TIME_MIN, RESPAWN_SAVE_TIME_MAX))
    else
        mob:setRespawnTime(math.random(7200, 14400))
    end

end

return entity
