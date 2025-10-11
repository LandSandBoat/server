-----------------------------------
-- Area: Al'Taieu
--  Mob: Ul'aern
-----------------------------------
mixins = { require('scripts/mixins/families/aern') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    local job = mob:getMainJob()
    if job == xi.job.BST then
        xi.pet.setMobPet(mob, 3, 'Aerns_Xzomit')
    elseif job == xi.job.DRG then
        xi.pet.setMobPet(mob, 1, 'Aerns_Wynav')
    elseif job == xi.job.SMN then
        xi.pet.setMobPet(mob, 3, 'Aerns_Elemental')
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
