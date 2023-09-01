-----------------------------------
-- Area: Castle Oztroja [S]
--   NM: Maa Illmu the Bestower
-- TODO:
--  Test what spells it casts at what HPP.
--  Immune to spell interruption from melee attacks. Only stuns and silence will interrupt it.
--  Will not use TP moves unless silenced - when Silence is inflicted it will immediately use Shirahadori if it has TP.
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 6)
    mob:setMod(xi.mod.SILENCE_MEVA, 100)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(7200, 14400)) -- 2 to 4 hours
end

return entity
