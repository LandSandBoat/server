-----------------------------------
-- Area: Uleguerand Range
--   NM: Skvader
-----------------------------------
local ID = zones[xi.zone.ULEGUERAND_RANGE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.SKVADER - 2] = ID.mob.SKVADER, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 321)
end

return entity
