-----------------------------------
-- Area: Periqia (Requiem)
--  Mob: Draconic Draugar
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    local instance = mob:getInstance()
    local petId    = mob:getID() + 1
    local pet      = GetMobByID(petId, instance)
    mob:setMobMod(xi.mobMod.NO_LINK, 1)
    mob:setMaxMP(4150)
    mob:setHP(4150)
    if pet then
        mob:setPet(pet)
    end
end

entity.onMobFight = function(mob, target)
    local pet = GetMobByID(mob:getID() + 1, mob:getInstance())
    if pet and pet:getCurrentAction() == xi.action.category.ROAMING then
        pet:updateEnmity(target)
    end
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    instance:setProgress(instance:getProgress() + 1)
end

return entity
