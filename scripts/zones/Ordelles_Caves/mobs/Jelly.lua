-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Jelly
-- Note: PH for Agar Agar
-----------------------------------
local ID = zones[xi.zone.ORDELLES_CAVES]
-----------------------------------
---@type TMobEntity
local entity = {}

local agarPHTable =
{
    [ID.mob.AGAR_AGAR - 4] = ID.mob.AGAR_AGAR, -- -81.31 31.493 210.675
    [ID.mob.AGAR_AGAR - 3] = ID.mob.AGAR_AGAR, -- -76.67 31.163 186.602
    [ID.mob.AGAR_AGAR - 2] = ID.mob.AGAR_AGAR, -- -80.77 31.979 193.542
    [ID.mob.AGAR_AGAR - 1] = ID.mob.AGAR_AGAR, -- -79.82 31.968 208.309
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 659, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, agarPHTable, 5, 3600) -- 1 hour
end

return entity
