-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Onki
-- a Thief in Norg BCNM Fight
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Onibi')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
