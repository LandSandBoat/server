-----------------------------------
-- Area: Middle Delkfutt's Tower
--   NM: Rhoitos
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.MIDDLE_DELKFUTTS_TOWER]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  88.000, y = -79.000, z =  73.000 }
}

entity.phList =
{
    [ID.mob.RHOITOS + 3] = ID.mob.RHOITOS, -- Giant_Sentry:
    [ID.mob.RHOITOS - 5] = ID.mob.RHOITOS, -- Giant_Lobber:     70 -80.094 80
    [ID.mob.RHOITOS + 2] = ID.mob.RHOITOS, -- Giant_Guard:      77.924 -80.084 70.787
    [ID.mob.RHOITOS + 1] = ID.mob.RHOITOS, -- Giant_Gatekeeper: 81.445 -79.977 71.427
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 336)
end

return entity
