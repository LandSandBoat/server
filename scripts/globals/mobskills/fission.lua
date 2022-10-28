-----------------------------------
-- Gorger NM Fission Skill
-- Checks eligibility to use
-- maxBabies set by NM lua
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local id = mob:getID()

    for i = id + 1, id + mob:getLocalVar("maxBabies") do
        local baby = GetMobByID(i)
        if not baby:isSpawned() then
            return 0
        end
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local id = mob:getID()
    local pos = mob:getPos()

    -- Ingester - ENM: You are what you eat
    if mob:getPool() == 2080 then
        for i = 4, 1, -1 do
            if not GetMobByID(id + i):isSpawned() then
                GetMobByID(id + i):setSpawn(pos.x, pos.y, pos.z)
                SpawnMob(id + i):updateEnmity(mob:getTarget())
                break
            end
        end
    else
        for babyID = id + 1, id + mob:getLocalVar("maxBabies") do
            local baby = GetMobByID(babyID)
            if not baby:isSpawned() then
                SpawnMob(babyID):updateEnmity(mob:getTarget())
                baby:setPos(pos.x, pos.y, pos.z)
                break
            end
        end
    end

    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskillObject
