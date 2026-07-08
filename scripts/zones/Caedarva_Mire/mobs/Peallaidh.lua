-----------------------------------
-- Area: Caedarva Mire
--  Mob: Peallaidh
-----------------------------------
mixins = { require('scripts/mixins/families/chigoe_pet') }
local ID = zones[xi.zone.CAEDARVA_MIRE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  279.313, y = -16.214, z = -390.119 }
}

entity.phList =
{
    [ID.mob.PEALLAIDH_PH_OFFSET + 3] = ID.mob.PEALLAIDH, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 468)
end

return entity
