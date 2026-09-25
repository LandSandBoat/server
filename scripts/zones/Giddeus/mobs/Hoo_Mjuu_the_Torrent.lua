-----------------------------------
-- Area: Giddeus (145)
--   NM: Hoo Mjuu the Torrent
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.GIDDEUS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.HOO_MJUU_THE_TORRENT - 2] = ID.mob.HOO_MJUU_THE_TORRENT, -- Confirmed on retail
}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.mobSkill.BENEDICTION_1, hpp = math.randomInt(10, 50) },
        },
    })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 281)
    xi.magian.onMobDeath(mob, player, optParams, set{ 364 })
end

return entity
