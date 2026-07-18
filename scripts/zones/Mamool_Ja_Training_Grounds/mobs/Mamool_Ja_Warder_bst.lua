-----------------------------------
-- Area: Mamool Ja Training Grounds (Imperial Agent Rescue)
--  MOB: Mamool Ja Warder (BST)
-----------------------------------
mixins = { require('scripts/mixins/weapon_break') }

local warder = require('scripts/zones/Mamool_Ja_Training_Grounds/globals/warder')
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    warder.onMobSpawn(mob)

    local instance = mob:getInstance()
    local petId    = mob:getID() + 1
    local pet      = GetMobByID(petId, instance)

    if pet then
        mob:setPet(pet)
        DisallowRespawn(petId, true)

        mob:timer(5000, function(mobArg)
            local currentPet = GetMobByID(petId, instance)
            if not currentPet or currentPet:isSpawned() then
                return
            end

            local pos = mobArg:getPos()
            currentPet:setSpawn(
                pos.x + math.randomInt(-2, 2),
                pos.y,
                pos.z + math.randomInt(-2, 2)
            )

            SpawnMob(petId, instance)
        end)
    end

    mob:addMod(xi.mod.MAIN_DMG_RATING, 45)
    mob:setMod(xi.mod.STR, 15)
    mob:setMod(xi.mod.ATT, 320)
end

entity.onMobFight = function(mob, target)
    local pet = GetMobByID(mob:getID() + 1, mob:getInstance())
    if pet and pet:getCurrentAction() == xi.action.category.ROAMING then
        pet:updateEnmity(target)
    end
end

entity.onMobWeaponSkill = warder.onMobWeaponSkill

return entity
