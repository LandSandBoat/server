-----------------------------------
-- Area: Rolanberry Fields
--  Mob: Evil Weapon
-- Note: PH for Eldritch Edge
-----------------------------------
local ID = zones[xi.zone.ROLANBERRY_FIELDS]
-----------------------------------
local entity = {}

local eldritchPHTable =
{
    [ID.mob.ELDRITCH_EDGE + 2] = ID.mob.ELDRITCH_EDGE, -- 440 -28 -44
    [ID.mob.ELDRITCH_EDGE - 2] = ID.mob.ELDRITCH_EDGE, -- 396.992 -24.01 -152.613
    [ID.mob.ELDRITCH_EDGE - 1] = ID.mob.ELDRITCH_EDGE, -- 395 -24 -147
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, eldritchPHTable, 20, math.random(5400, 7200)) -- 90 to 120 minutes
end

return entity
