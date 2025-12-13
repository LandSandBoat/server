-----------------------------------
-- Area : Throne Room
-- Mob  : Duke Dantalian
-- BCNM : Kindred Spirits
-- Job  : Summoner
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 2, 'Demons_Elemental')
    mob:setMobMod(xi.mobMod.ASTRAL_PET_OFFSET, 3)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 6)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 7)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
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
