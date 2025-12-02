-----------------------------------
-- Area: Horlais Peak
--  Mob: Derakbak of Clan Wolf
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 3, 'Orcs_Wyvern')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
