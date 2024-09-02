-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Typhoon Wyvern
-- Note: Place holder Ungur
-----------------------------------
local ID = zones[xi.zone.GUSTAV_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

local ungurPHTable =
{
    [ID.mob.UNGUR + 37] = ID.mob.UNGUR, -- -88.000 0.735 190.000
    [ID.mob.UNGUR + 29] = ID.mob.UNGUR, -- -123.856 0.239 223.303
    [ID.mob.UNGUR + 9]  = ID.mob.UNGUR, -- -242.000 -0.577 120.000
    [ID.mob.UNGUR + 3]  = ID.mob.UNGUR, -- -277.000 -10.000 -34.000
    [ID.mob.UNGUR - 1]  = ID.mob.UNGUR, -- -316.000 -9.000 3.000
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 769, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ungurPHTable, 5, 7200) -- 2 hours
end

return entity
