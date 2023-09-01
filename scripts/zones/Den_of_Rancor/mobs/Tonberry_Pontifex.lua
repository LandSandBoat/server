-----------------------------------
-- Area: Den of Rancor
--   NM: Tonberry Pontifex
-----------------------------------
mixins =
{
    require('scripts/mixins/families/tonberry'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 798, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 799, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 800, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(75600, 86400)) -- 21 to 24 hours
end

return entity
