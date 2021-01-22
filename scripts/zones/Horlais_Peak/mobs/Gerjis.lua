-----------------------------------
-- Area: Horlais Peak
--  Mob: Gerjis
-- BCNM: Eye of the Tiger
-- TODO: code special attacks Crossthrash and Gerjis' Grip
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(tpz.mod.EVA, 50)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
