-----------------------------------
-- Area : Sacrificial Chamber
-- Mob  : Pevv the Riverleaper
-- BCNM : Amphibian Assault
-- Job  : Dragoon
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 2, 'Sahagins_Wyvern')
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 4)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 4)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.CALL_WYVERN, hpp = 75 },
        },
    })
end

entity.onMobFight = function(mob, target)
    local mobId = mob:getID()
    local pet   = GetMobByID(mobId + 2)

    if
        pet and
        pet:isSpawned() and
        pet:getCurrentAction() == xi.action.category.ROAMING
    then
        pet:updateEnmity(target)
    end
end

return entity
