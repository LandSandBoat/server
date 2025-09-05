-----------------------------------
-- Area: Fort Karugo-Narugo [S]
--   NM: Demoiselle Desolee
-----------------------------------
local ID = zones[xi.zone.FORT_KARUGO_NARUGO_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -51.734, y = -28.457, z =  686.549 }
}

entity.phList =
{
    [ID.mob.DEMOISELLE_DESOLEE + 8] = ID.mob.DEMOISELLE_DESOLEE,
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PARALYZE, { duration = 60 })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 524)
end

return entity
