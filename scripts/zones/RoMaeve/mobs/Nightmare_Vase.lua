-----------------------------------
-- Area: RoMaeve
--   NM: Nightmare Vase
-----------------------------------
local ID = zones[xi.zone.ROMAEVE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.NIGHTMARE_VASE[1] - 19] = ID.mob.NIGHTMARE_VASE[1], -- Confirmed on retail
    [ID.mob.NIGHTMARE_VASE[1] - 1] = ID.mob.NIGHTMARE_VASE[1], -- Confirmed on retail
    [ID.mob.NIGHTMARE_VASE[2] - 20] = ID.mob.NIGHTMARE_VASE[2], -- Confirmed on retail
    [ID.mob.NIGHTMARE_VASE[2] - 1] = ID.mob.NIGHTMARE_VASE[2], -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 10)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 327)
end

entity.onMobDespawn = function(mob)
end

return entity
