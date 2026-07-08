-----------------------------------
-- Area: Hazhalm Testing Grounds
--   NM: Reifnir (Einherjar; Motsognir add)
-- Notes: Superlink with Motsognir and the other 11 demons.
-- Immune to petrify.
-----------------------------------
local ID = zones[xi.zone.HAZHALM_TESTING_GROUNDS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:setMobMod(xi.mobMod.SUPERLINK, ID.mob.MOTSOGNIR)
end

return entity
