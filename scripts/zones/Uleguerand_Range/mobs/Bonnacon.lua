-----------------------------------
-- Area: Uleguerand Range
--   NM: Bonnacon
-----------------------------------
local ID = zones[xi.zone.ULEGUERAND_RANGE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -615.121, y = -40.062, z =  6.126 }
}

entity.phList =
{
    [ID.mob.BONNACON - 6] = ID.mob.BONNACON, -- -623.154 -40.604 -51.621
    [ID.mob.BONNACON - 5] = ID.mob.BONNACON, -- -587.026 -40.994 -22.551
    [ID.mob.BONNACON - 4] = ID.mob.BONNACON, -- -513.416 -40.490 -43.706
    [ID.mob.BONNACON - 3] = ID.mob.BONNACON, -- -553.844 -38.958 -53.864
    [ID.mob.BONNACON - 2] = ID.mob.BONNACON, -- -631.268 -40.257 0.709
    [ID.mob.BONNACON - 1] = ID.mob.BONNACON, -- -513.999 -40.541 -34.928
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN, { chance = 65, duration = math.random(5, 15) })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 319)
end

return entity
