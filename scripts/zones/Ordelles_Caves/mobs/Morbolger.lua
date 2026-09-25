-----------------------------------
-- Area: Ordelles Caves (193)
--   NM: Morbolger
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(math.randomInt(3600, 7200)) -- 1 to 2 hours

    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1) -- "Aggros regardless of level"
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.MORBOLBANE)
    end
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(3600, 7200)) -- 1 to 2 hours
end

return entity
