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
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -17.176, y = -16.250, z = -16.468 }
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(900, 10800))

    mob:setMobMod(xi.mobMod.MAGIC_COOL, 6)
    mob:setMod(xi.mod.SILENCE_MEVA, 100)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(7200, 14400)) -- 2 to 4 hours
end

return entity
