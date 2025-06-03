-----------------------------------
-- Area: Labyrinth of Onzozo
--   NM: Mysticmaker Profblix
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.STUN)
    mob:addMod(xi.mod.SILENCE_MEVA, 80)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 771, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 772, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 774, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(24, 30) * 300) -- 2 to 2.5 hours in 5 minute windows
end

return entity
