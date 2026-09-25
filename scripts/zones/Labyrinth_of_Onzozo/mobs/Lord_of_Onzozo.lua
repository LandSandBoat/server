-----------------------------------
-- Area: Labyrinth of Onzozo
--   NM: Lord of Onzozo
-----------------------------------
mixins =
{
    require('scripts/mixins/rage'),
    require('scripts/mixins/draw_in'),
}
-----------------------------------
local ID = zones[xi.zone.LABYRINTH_OF_ONZOZO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.LORD_OF_ONZOZO - 1] = ID.mob.LORD_OF_ONZOZO, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.STORETP, 75) -- This is the amount of STP required for LOO to reach 1k TP via auto attacks in testing.
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)

    mob:setMod(xi.mod.SILENCE_RES_RANK, 10)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 774, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
end

return entity
