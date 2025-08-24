-----------------------------------
-- Area: Davoi
--  Mob: Orcish Impaler
-- Note: PH for Poisonhand Gnadgad and Steelbiter Gudrud
-----------------------------------
local ID = zones[xi.zone.DAVOI]
-----------------------------------
---@type TMobEntity
local entity = {}

local steelbiterPHTable =
{
    [ID.mob.STEELBITER_GUDRUD - 7] = ID.mob.STEELBITER_GUDRUD, -- 252.457 3.501 -248.655
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.POISONHAND_GNADGAD, 10, 3600) -- 1 hour
    xi.mob.phOnDespawn(mob, steelbiterPHTable, 10, 3600) -- 1 hour
end

return entity
