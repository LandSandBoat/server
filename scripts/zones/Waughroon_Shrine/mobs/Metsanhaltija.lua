-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Metsanhaltija
-- BCNM: Grove Guardians
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(tpz.mod.SLEEPRES, 50)
end

function onMobDeath(mob, player, isKiller)
end

return entity
