-----------------------------------
-- Area: Davoi
--  Mob: War Lizard
-- Note: PH for Tigerbane Bakdak
-----------------------------------
local ID = zones[xi.zone.DAVOI]
-----------------------------------
---@type TMobEntity
local entity = {}

local tigerbanePHTable =
{
    [ID.mob.TIGERBANE_BAKDAK - 4] = ID.mob.TIGERBANE_BAKDAK, -- 158 -0.662 -18
    [ID.mob.TIGERBANE_BAKDAK - 3] = ID.mob.TIGERBANE_BAKDAK, -- 153.880 -0.769 -18.092
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, tigerbanePHTable, 10, 3600) -- 1 hour
end

return entity
