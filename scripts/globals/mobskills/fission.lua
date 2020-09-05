---------------------------------------------------
-- Gorger NM Fission Skill
-- Checks eligibility to use
-- maxBabies set by NM lua
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local momma = mob:getID()
    local fam = 1
    for i = momma + 1, momma + mob:getLocalVar("maxBabies") do
        local baby = GetMobByID(i)
        if not baby:isSpawned() then
            fam = 0
            break
        end
    end
    return fam
end

function onMobWeaponSkill(target, mob, skill)
    local momma = mob:getID()
    local pos = mob:getPos()
    for babyID = momma + 1, momma + mob:getLocalVar("maxBabies") do
        local baby = GetMobByID(babyID)
        if not baby:isSpawned() then
            SpawnMob(babyID):updateEnmity(mob:getTarget())
            baby:setPos(pos.x, pos.y, pos.z)
            break
        end
    end
end
