-----------------------------------
-- Gorger NM Fission Skill
-- Checks eligibility to use
-- maxBabies set by NM lua
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    local id = mob:getID()

    -- Progenerator - Ancient Flames Beckon
    if mob:getPool() == 3204 then
        for i = id + 1, id + mob:getLocalVar("maxBabies") do
            local baby = GetMobByID(i)
            if not baby:isSpawned() then
                return 0
            end
        end
    end

    return 1
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local id = mob:getID()
    local pos = mob:getPos()

    -- Ingester - ENM: You are what you eat
    if mob:getPool() == 2080 then
        for i = 4, 1, -1 do
            if not GetMobByID(id+i):isSpawned() then
                GetMobByID(id+i):setSpawn(pos.x, pos.y, pos.z)
                SpawnMob(id+i):updateEnmity(mob:getTarget())
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

return mobskill_object
