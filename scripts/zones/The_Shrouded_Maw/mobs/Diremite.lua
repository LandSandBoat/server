-----------------------------------
-- Area: The Shrouded Maw
-- Diabolos Mission and Avatar Fight
--  Mob: Diremite
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDisengage = function(mob)
    local spawnPos = mob:getSpawnPos()
    local currentY = mob:getYPos()

    -- Despawn if too far from spawn
    if math.abs(currentY - spawnPos.y) > 3 or mob:checkDistance(spawnPos) > 15 then
        DespawnMob(mob:getID())
    end
end

entity.onMobDespawn = function(mob)
    -- Track death time for 10-second respawn
    mob:setLocalVar('deathTime', GetSystemTime())
end

return entity
