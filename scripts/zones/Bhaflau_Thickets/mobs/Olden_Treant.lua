-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Olden Treant
-- Note: Place holder Emergent Elm
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_THICKETS]
-----------------------------------
local entity = {}

local elmPHTable =
{
    [ID.mob.EMERGENT_ELM - 2] = ID.mob.EMERGENT_ELM, -- 86.000 -35.000 621.000
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, elmPHTable, 5, 14400) -- 4 hours
end

return entity
