-----------------------------------
-- Area: Throne Room
--  Mob: Duke Dantalian
-- BCNM: Kindred Spirits
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ASTRAL_PET_OFFSET, 3)
end

entity.onMobSpawn = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    local elementalId = mob:getID() + 2
    if GetMobByID(elementalId):isSpawned() then
        DespawnMob(elementalId)
    end
end

return entity
