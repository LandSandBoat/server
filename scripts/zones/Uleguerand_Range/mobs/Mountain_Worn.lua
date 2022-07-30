-----------------------------------
-- Area: Uleguerand Range
--   NM: Mountain Worm
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.REGEN, 50)
end

return entity
