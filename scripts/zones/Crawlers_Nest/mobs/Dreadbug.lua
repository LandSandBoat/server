-----------------------------------
-- Area: Crawlers Nest
--   NM: Dreadbug
-- Used in Quests: A Boy's Dream
-- !pos -18 -8 124 197
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
