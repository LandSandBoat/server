-----------------------------------
-- Area: Davoi
--  Mob: Orcish Impaler
-- Note: PH for Poisonhand Gnadgad and Steelbiter Gudrud
-----------------------------------
local ID = zones[xi.zone.DAVOI]
-----------------------------------
local entity = {}

local steelbiterPHTable =
{
    [ID.mob.STEELBITER_GUDRUD - 7] = ID.mob.STEELBITER_GUDRUD, -- 252.457 3.501 -248.655
}

local poisonhandPHTable =
{
    [ID.mob.POISONHAND_GNADGAD - 10] = ID.mob.POISONHAND_GNADGAD, -- -53.910 -0.583 56.606
    [ID.mob.POISONHAND_GNADGAD - 6]  =  ID.mob.POISONHAND_GNADGAD, -- -50.158 -0.537 22.257
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, poisonhandPHTable, 10, 3600) -- 1 hour
    xi.mob.phOnDespawn(mob, steelbiterPHTable, 10, 3600) -- 1 hour
end

return entity
