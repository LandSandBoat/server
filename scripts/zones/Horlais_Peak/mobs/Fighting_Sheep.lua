-----------------------------------
-- Area: Horlais Peak
--  Mob: Fighting Sheep
-- BCNM: Hostile Herbivores
-- TODO: melee attacks cause knockback.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.ICE_RES, 75) -- Todo: Move to mob_resists.sql
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
