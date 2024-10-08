-----------------------------------
-- Area: RoMaeve
--  Mob: Magic Flagon
-- Note: PH for Nightmare Vase and Rogue Receptacle
-----------------------------------
local ID = zones[xi.zone.ROMAEVE]
-----------------------------------
---@type TMobEntity
local entity = {}

local nightmarePHTable =
{
    [ID.mob.NIGHTMARE_VASE[1] - 1] = ID.mob.NIGHTMARE_VASE[1], -- -101.575 -6.099 -1.520 (west)
    [ID.mob.NIGHTMARE_VASE[2] - 5] = ID.mob.NIGHTMARE_VASE[2], -- 59.825 -5.760 25.123 (east) (Needs Audit)
}

local roguePHTable =
{
    [ID.mob.ROGUE_RECEPTACLE - 4] = ID.mob.ROGUE_RECEPTACLE,
    [ID.mob.ROGUE_RECEPTACLE - 1] = ID.mob.ROGUE_RECEPTACLE,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 120, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, nightmarePHTable, 10, 3600) -- 1 hour
    xi.mob.phOnDespawn(mob, roguePHTable, 10, 7200) -- 2 hour
end

return entity
