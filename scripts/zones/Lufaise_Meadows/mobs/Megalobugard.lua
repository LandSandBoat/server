-----------------------------------
-- Area: Lufaise Meadows
--   NM: Megalobugard
-----------------------------------
local ID = zones[xi.zone.LUFAISE_MEADOWS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.MEGALOBUGARD - 30] = ID.mob.MEGALOBUGARD, -- Confirmed on retail
    [ID.mob.MEGALOBUGARD - 21] = ID.mob.MEGALOBUGARD, -- Confirmed on retail
    [ID.mob.MEGALOBUGARD - 2]  = ID.mob.MEGALOBUGARD, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.REGEN, 55)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 439)
    xi.magian.onMobDeath(mob, player, optParams, set{ 154, 368, 582 })
end

return entity
