-----------------------------------
-- Area: Misareaux_Coast
--  Mob: Gigas Warwolf
-----------------------------------
mixins = { require('scripts/mixins/fomor_hate') }
local ID = zones[xi.zone.MISAREAUX_COAST]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    -- the pet offsets for these mobs range from 2 to 6, simpler to map via matching table indexes
    for i, mobId in ipairs(ID.mob.GIGAS_WARWOLF) do
        local petId = ID.mob.GIGASS_SHEEP[i]
        if mobId == mob:getID() and petId then
            xi.pet.setMobPet(mob, petId - mobId, 'Gigass_Sheep')
        end
    end
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('fomorHateAdj', 1)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
