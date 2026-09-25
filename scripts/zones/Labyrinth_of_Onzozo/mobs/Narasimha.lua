-----------------------------------
-- Area: Labyrinth of Onzozo
--   NM: Narasimha
-----------------------------------
local ID = zones[xi.zone.LABYRINTH_OF_ONZOZO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.NARASIMHA - 1] = ID.mob.NARASIMHA, -- Confirmed on retail
    [ID.mob.NARASIMHA + 3] = ID.mob.NARASIMHA, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)

    mob:setMobMod(xi.mobMod.GIL_MIN, 12000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 12000)
    mob:setMobMod(xi.mobMod.MUG_GIL, 4800)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 299)
end

entity.onMobDespawn = function(mob)
end

return entity
