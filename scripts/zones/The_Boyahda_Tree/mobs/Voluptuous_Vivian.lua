-----------------------------------
-- Area: The Boyahda Tree
--   NM: Voluptuous Vivian
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:setMobMod(xi.mobMod.DRAW_IN_INCLUDE_PARTY, 1)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.THE_VIVISECTOR)
end

return entity
