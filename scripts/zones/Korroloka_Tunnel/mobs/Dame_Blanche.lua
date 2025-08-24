-----------------------------------
-- Area: Korroloka Tunnel (173)
--   NM: Dame Blanche
-----------------------------------
local ID = zones[xi.zone.KORROLOKA_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.DAME_BLANCHE - 1] =  ID.mob.DAME_BLANCHE, -- -345.369 0.716 119.486
    [ID.mob.DAME_BLANCHE - 2] =  ID.mob.DAME_BLANCHE, -- -319.266 -0.244 130.650
    [ID.mob.DAME_BLANCHE - 3] =  ID.mob.DAME_BLANCHE, -- -319.225 -0.146 109.776
    [ID.mob.DAME_BLANCHE - 5] =  ID.mob.DAME_BLANCHE, -- -296.821 -3.207 131.239
    [ID.mob.DAME_BLANCHE - 4] =  ID.mob.DAME_BLANCHE, -- -292.487 -5.993 141.408
    [ID.mob.DAME_BLANCHE - 10] = ID.mob.DAME_BLANCHE, -- -277.338 -9.352 139.763
    [ID.mob.DAME_BLANCHE - 11] = ID.mob.DAME_BLANCHE, -- -276.713 -9.954 135.353
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.GIL_MIN, 3600)
    mob:setMobMod(xi.mobMod.GIL_MAX, 6079)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TERROR)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 228)
end

return entity
