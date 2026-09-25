-----------------------------------
-- Area: Sea Serpent Grotto (176)
--   NM: Charybdis
-- !pos -152 48 -328 176
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.CHARYBDIS - 4] = ID.mob.CHARYBDIS, -- Confirmed on retail
    [ID.mob.CHARYBDIS - 1] = ID.mob.CHARYBDIS, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MULTI_HIT, 8) -- TODO : This is not correct. Will need to be updated to proper multi-hit handling later.

    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)

    mob:setMobMod(xi.mobMod.GIL_MIN, 18000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 18000)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 11)

    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

return entity
