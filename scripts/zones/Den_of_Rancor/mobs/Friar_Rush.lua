-----------------------------------
-- Area: Den of Rancor
--   NM: Friar Rush
-----------------------------------
local ID = zones[xi.zone.DEN_OF_RANCOR]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.FRIAR_RUSH - 2] = ID.mob.FRIAR_RUSH,
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 9000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 9000)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 394)
end

return entity
