-----------------------------------
-- Area: Castle Oztroja (151)
--  Mob: Yagudo Drummer
-- Note: PH for Mee Deggi the Punisher
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
---@type TMobEntity
local entity = {}

local meeDeggiPHTable =
{
    [ID.mob.MEE_DEGGI_THE_PUNISHER - 34] = ID.mob.MEE_DEGGI_THE_PUNISHER, -- -178.119 -0.644 153.039
    [ID.mob.MEE_DEGGI_THE_PUNISHER - 25] = ID.mob.MEE_DEGGI_THE_PUNISHER, -- -235.639 -0.063 103.280
    [ID.mob.MEE_DEGGI_THE_PUNISHER - 17] = ID.mob.MEE_DEGGI_THE_PUNISHER, -- -233.116 -0.741 172.067
    [ID.mob.MEE_DEGGI_THE_PUNISHER - 2]  = ID.mob.MEE_DEGGI_THE_PUNISHER, -- -207.840 -0.498 109.939
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, meeDeggiPHTable, 5, 3000) -- 50 minutes
end

return entity
