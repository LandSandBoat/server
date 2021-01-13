-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Gladiatorial Weapon
-- BCNM: Die by the Sword
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(tpz.mod.UDMGMAGIC, -100)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
