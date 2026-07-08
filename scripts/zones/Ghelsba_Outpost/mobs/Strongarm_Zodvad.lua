-----------------------------------
-- Area: Ghelsba Outpost
--   NM: Strongarm Zodvad
-- Involved in Mission: Save the Children
-----------------------------------
local ID = zones[xi.zone.GHELSBA_OUTPOST]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:setMobMod(xi.mobMod.SUPERLINK, ID.mob.FODDERCHIEF_VOKDEK)
end

return entity
