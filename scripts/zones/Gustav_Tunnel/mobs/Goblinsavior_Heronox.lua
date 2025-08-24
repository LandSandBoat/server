-----------------------------------
-- Area: Gustav Tunnel
--   NM: Goblinsavior Heronox
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.GUSTAV_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.GOBLINSAVIOR_HERONOX - 4] = ID.mob.GOBLINSAVIOR_HERONOX,  -- 152.325 -10.702 -77.007
    [ID.mob.GOBLINSAVIOR_HERONOX - 5] = ID.mob.GOBLINSAVIOR_HERONOX,  -- 165.558 -10.647 -68.537
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 6000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 6000)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 423)
end

return entity
