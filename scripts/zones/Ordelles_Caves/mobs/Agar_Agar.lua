-----------------------------------
-- Area: Ordelle's Caves
--   NM: Agar Agar
-----------------------------------
local ID = zones[xi.zone.ORDELLES_CAVES]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -71.360, y =  31.975, z =  207.479 }
}

entity.phList =
{
    [ID.mob.AGAR_AGAR - 4] = ID.mob.AGAR_AGAR, -- -81.31 31.493 210.675
    [ID.mob.AGAR_AGAR - 3] = ID.mob.AGAR_AGAR, -- -76.67 31.163 186.602
    [ID.mob.AGAR_AGAR - 2] = ID.mob.AGAR_AGAR, -- -80.77 31.979 193.542
    [ID.mob.AGAR_AGAR - 1] = ID.mob.AGAR_AGAR, -- -79.82 31.968 208.309
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PARALYZE)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 183)
end

return entity
