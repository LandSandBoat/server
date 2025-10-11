-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Maat
-- Genkai 5 Fight
-----------------------------------
mixins = { require('scripts/mixins/families/maat') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Maats_Pet')
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
    mob:setMobMod(xi.mobMod.ROAM_TURNS, 0)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
