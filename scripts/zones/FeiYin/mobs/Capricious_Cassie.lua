-----------------------------------
-- Area: Fei'Yin
--   NM: Capricious Cassie
-----------------------------------
mixins = { require("scripts/mixins/rage") }
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.CASSIENOVA)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(75600, 86400)) -- 21 to 24 hours
end

return entity
