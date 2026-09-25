-----------------------------------
-- Area: Labyrinth of Onzozo
--   NM: Mysticmaker Profblix
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(math.randomInt(24, 30) * 300)

    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)

    mob:setMobMod(xi.mobMod.GIL_MIN, 6000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 6000)
end

-- Mysticmaker has increased magic damage.  The specifics of which need to be further tested and added.

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 9)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 9)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 10)
    mob:setMod(xi.mod.SPELLINTERRUPT, 90)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 771, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 772, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 774, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(24, 30) * 300) -- 2 to 2.5 hours in 5 minute windows
end

return entity
