-----------------------------------
-- Area: Al'Taieu
--  Mob: Om'aern
-----------------------------------
mixins = { require('scripts/mixins/families/aern') }
local ID = zones[xi.zone.ALTAIEU]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    -- the pet offsets for these mobs vary wildly, simpler to map via matching table indexes
    for i, mobId in ipairs(ID.mob.OMAERN_SMN) do
        -- there's one pet before the Omaerns that belongs to Ulaern, so increment by 1
        local petId = ID.mob.AERNS_ELEMENTAL[i + 1]
        if mobId == mob:getID() and petId then
            xi.pet.setMobPet(mob, petId - mobId, 'Aerns_Elemental')
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
