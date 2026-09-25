-----------------------------------
-- Area: Palborough Mines
--   NM: Be'Hya Hundredwall
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.PALBOROUGH_MINES]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.BEHYA_HUNDREDWALL - 2] = ID.mob.BEHYA_HUNDREDWALL, -- Confirmed on retail
    [ID.mob.BEHYA_HUNDREDWALL - 1] = ID.mob.BEHYA_HUNDREDWALL, -- Confirmed on retail
}

entity.onMobSpawn = function(mob)
    mob:addStatusEffect(xi.effect.STONESKIN, { power = math.randomInt(60, 70), duration = 300, origin = mob })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 222)
    xi.magian.onMobDeath(mob, player, optParams, set{ 941 })
end

return entity
