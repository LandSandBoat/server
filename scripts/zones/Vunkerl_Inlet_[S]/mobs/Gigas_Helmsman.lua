-----------------------------------
-- Area: Vunkerl Inlet [S]
--   NM: Gigas Helmsman
-----------------------------------
local ID = zones[xi.zone.VUNKERL_INLET_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Gigass_Tiger')
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.PALLAS, 5, math.random(1, 5) * 60 * 60) -- 1-5 hours
end

return entity
