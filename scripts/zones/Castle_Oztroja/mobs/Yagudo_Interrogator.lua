-----------------------------------
-- Area: Castle Oztroja (151)
--  Mob: Yagudo Interrogator
-- Note: PH for Mee Deggi the Punisher
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
---@type TMobEntity
local entity = {}

local meeDeggiPHTable =
{
    [ID.mob.MEE_DEGGI_THE_PUNISHER - 39] = ID.mob.MEE_DEGGI_THE_PUNISHER, -- -207.370 -0.056 106.537
    [ID.mob.MEE_DEGGI_THE_PUNISHER - 31] = ID.mob.MEE_DEGGI_THE_PUNISHER, -- -188.253 -0.087 158.955
    [ID.mob.MEE_DEGGI_THE_PUNISHER - 16] = ID.mob.MEE_DEGGI_THE_PUNISHER, -- -254.302 -0.057 163.759
    [ID.mob.MEE_DEGGI_THE_PUNISHER - 1]  = ID.mob.MEE_DEGGI_THE_PUNISHER, -- -227.415 -4.340 145.213
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, meeDeggiPHTable, 5, 3000) -- 50 minutes
end

return entity
