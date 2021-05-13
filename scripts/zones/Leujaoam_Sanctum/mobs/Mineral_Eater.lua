-----------------------------------
-- Area: Leujaoam Sanctum (Orichalcum Survey)
--  Mob: Mineral Eater
-- Immune to Charm
-----------------------------------
require("scripts/globals/assault")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    assaultUtil.adjustMobLevel(mob, mob:getID())
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
