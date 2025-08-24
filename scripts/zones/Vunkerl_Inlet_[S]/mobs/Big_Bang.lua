-----------------------------------
-- Area: Vunkerl Inlet [S]
--   NM: Big Bang
-----------------------------------
local ID = zones[xi.zone.VUNKERL_INLET_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.BIG_BANG - 2] = ID.mob.BIG_BANG,
    [ID.mob.BIG_BANG - 1] = ID.mob.BIG_BANG,
}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.MOVE_SPEED_STACKABLE, 12)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 488)
end

return entity
