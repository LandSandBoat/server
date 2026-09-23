-----------------------------------
-- Area: Castle Zvahl Baileys
--   NM: Marquis Sabnock
-----------------------------------
local ID = zones[xi.zone.CASTLE_ZVAHL_BAILEYS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.MARQUIS_SABNOCK - 3] = ID.mob.MARQUIS_SABNOCK, -- Confirmed on retail
    [ID.mob.MARQUIS_SABNOCK - 2] = ID.mob.MARQUIS_SABNOCK, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TP_DRAIN, { power = math.randomInt(10, 60) })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 352)
end

return entity
