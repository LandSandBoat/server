-----------------------------------
-- Area: Jugner Forest
--   NM: Fraelissa
-----------------------------------
local ID = zones[xi.zone.JUGNER_FOREST]
-----------------------------------
local entity = {}

local updateRegen = function(mob)
    local hour = VanadielHour()
    if hour >= 4 and hour < 20 then
        mob:setMod(xi.mod.REGEN, 25)
    else
        mob:setMod(xi.mod.REGEN, 0)
    end
end

entity.onMobSpawn = function(mob)
    updateRegen(mob)
end

entity.onMobFight = function(mob)
    updateRegen(mob)
end

entity.onMobRoam = function(mob)
    updateRegen(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 158)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    if not xi.mob.phOnDespawn(mob, ID.mob.FRADUBIO_PH, 10, 75600) then -- 21 hour minimum
        mob:setRespawnTime(math.random(3600, 4500)) -- 60 to 75 minutes
    end
end

return entity
