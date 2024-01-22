-----------------------------------
-- Area: Boneyard Gully
--  Mob: Nepionic Parata
--  ENM: Shell We Dance?
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGAIN, 100)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
