-----------------------------------
-- Area: Palborough Mines
--   NM: Be'Hya Hundredwall
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addStatusEffect(xi.effect.STONESKIN, { power = math.randomInt(60, 70), duration = 300, origin = mob })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 222)
    xi.magian.onMobDeath(mob, player, optParams, set{ 941 })
end

return entity
