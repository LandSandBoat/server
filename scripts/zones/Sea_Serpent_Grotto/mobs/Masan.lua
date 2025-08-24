-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Masan
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.MASAN - 4] = ID.mob.MASAN, -- 17.001 9.340 186.571
    [ID.mob.MASAN - 3] = ID.mob.MASAN, -- 18.702 9.512 183.594
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 1500)
    mob:setMobMod(xi.mobMod.GIL_MAX, 1800)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 371)
end

return entity
