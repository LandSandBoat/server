-----------------------------------
-- Area: Temple of Uggalepih
-- Mob: Trompe L'Oeil
-- Note: Quest NM for "A Question of Taste"
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180) -- 3 minutes
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.GIL_BONUS, -100) -- No gil
    mob:setMobMod(xi.mobMod.NO_DROPS, 1) -- No drops
end

return entity
