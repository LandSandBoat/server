-----------------------------------
-- Area: Gusgen Mines
--   NM: Wandering Ghost
-- Involved In Quest: Ghosts of the Past
-- !pos -174 0.1 369 196
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:addMod(xi.mod.STATUSRES, 80) -- "Highly resistant to Enfeebling Magic and Ice Spell (Even at level 75)."
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
