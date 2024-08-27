-----------------------------------
-- Gorger NM Fission Skill
-- Checks eligibility to use
-- maxBabies set by NM lua
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local momma = mob:getID()
    local fam = 1
    for i = momma + 1, momma + mob:getLocalVar('maxBabies') do
        local baby = GetMobByID(i)
        if baby and not baby:isSpawned() then
            fam = 0
            break
        end
    end

    return fam
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local momma = mob:getID()
    local pos = mob:getPos()
    for babyID = momma + 1, momma + mob:getLocalVar('maxBabies') do
        local baby = GetMobByID(babyID)
        if baby and not baby:isSpawned() then
            SpawnMob(babyID)

            local mobTarget = mob:getTarget()
            if mobTarget then
                baby:updateEnmity(mobTarget)
            end

            baby:setPos(pos.x, pos.y, pos.z)
            break
        end
    end
end

return mobskillObject
