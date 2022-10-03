-----------------------------------
-- Area: Fei'Yin
--   NM: Capricious Cassie
-----------------------------------
mixins = { require("scripts/mixins/rage") }
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.DRAW_IN, 2)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.CASSIENOVA)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(75600, 86400)) -- 21-24 hours
end

return entity
