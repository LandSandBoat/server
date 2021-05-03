-----------------------------------
-- Area: Fort Ghelsba
--   NM: Orcish Panzer
-- Note: PH for Chariotbuster Byakzak
-- !pos 23.935 -48.474 35.489 141
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    if (isKiller) then
        local mobId = mob:getID()
        local nq = GetMobByID(mobId + 1) -- Orcish Fighter
        local hq = GetMobByID(mobId + 2) -- Chariotbuster Byakzak

        DisallowRespawn(mobId, true)

        if os.time() > hq:getLocalVar("pop") then
            SpawnMob(mobId + 2):updateClaim(player)
            hq:setPos(mob:getXPos(), mob:getYPos(), mob:getZPos(), 0)
        else
            SpawnMob(mobId + 1):updateClaim(player)
            nq:setPos(mob:getXPos(), mob:getYPos(), mob:getZPos(), 0)
        end
    end
end

entity.onMobDespawn = function(mob)
    if RESPAWN_SAVE_TIME then
        mob:setRespawnTime(math.random(RESPAWN_SAVE_TIME_MIN, RESPAWN_SAVE_TIME_MAX))
    else
        mob:setRespawnTime(math.random(3600, 4200)) -- 60 to 70 minutes
    end
end

return entity
