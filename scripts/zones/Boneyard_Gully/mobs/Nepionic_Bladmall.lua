-----------------------------------
-- Area: Boneyard Gully
--  Mob: Nepionic Bladmall
--  ENM: Shell We Dance?
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, 1)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
