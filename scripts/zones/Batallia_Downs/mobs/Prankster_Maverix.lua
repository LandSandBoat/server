-----------------------------------
-- Area: Batallia Downs
--   NM: Prankster Maverix
-----------------------------------
local ID = zones[xi.zone.BATALLIA_DOWNS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.PRANKSTER_MAVERIX - 5] = ID.mob.PRANKSTER_MAVERIX,
}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.REGAIN, 50)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 164)
end

return entity
