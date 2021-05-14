-----------------------------------
-- Area: Periqia (Seagull Grounded)
--  Mob: Debaucher
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    --mob:addImmunity(xi.immunity.DARKSLEEP) TODO: Handle This
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
