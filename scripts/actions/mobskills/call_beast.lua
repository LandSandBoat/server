-----------------------------------
-- Call Beast
-- Call my pet.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:hasPet() or mob:getPet() == nil then
        return 1
    end

    return 0
end

local onMasterDeath = function(mob)
    if mob:hasPet() then
        local pet = mob:getPet()
        if pet ~= nil then
            if not pet:isEngaged() then
                DespawnMob(pet:getID(), 2)
            end
        end
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:spawnPet()

    skill:setMsg(xi.msg.basic.NONE)
    mob:addListener('DEATH', 'BEASTMASTER_DEATH', onMasterDeath)
    mob:addListener('DESPAWN', 'BEASTMASTER_DESPAWN', onMasterDeath)

    return 0
end

return mobskillObject
