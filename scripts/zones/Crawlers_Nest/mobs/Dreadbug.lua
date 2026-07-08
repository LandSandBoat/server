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

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:setMod(xi.mod.STORETP, 125) -- 6 hits to 1ktp
end

return entity
