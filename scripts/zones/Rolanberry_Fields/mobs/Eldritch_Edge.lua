-----------------------------------
-- Area: Rolanberry Fields
--   NM: Eldritch Edge
-----------------------------------
local ID = zones[xi.zone.ROLANBERRY_FIELDS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.ELDRITCH_EDGE + 2] = ID.mob.ELDRITCH_EDGE, -- 440 -28 -44
    [ID.mob.ELDRITCH_EDGE - 2] = ID.mob.ELDRITCH_EDGE, -- 396.992 -24.01 -152.613
    [ID.mob.ELDRITCH_EDGE - 1] = ID.mob.ELDRITCH_EDGE, -- 395 -24 -147
}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:setMod(xi.mod.STORETP, 25)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 218)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
end

return entity
