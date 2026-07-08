-----------------------------------
-- Boreas Mantle
-- Description: Spawns 4 clones of itself that disappear after 30 seconds
-- Used only by Phantom Puk
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local mobId   = mob:getID()
    local player  = mob:getTarget()
    local clonehp = 500
    local hpp     = mob:getHPP() / 100
    local maxhp   = math.ceil(clonehp / hpp)

    for cloneId = mobId + 1, mobId + 4 do
        local clone = SpawnMob(cloneId)
        if clone then
            clone:setMaxHP(maxhp)
            clone:setHP(clonehp)
            if player then
                clone:updateEnmity(player)
            end

            clone:setPos(mob:getXPos(), mob:getYPos(), mob:getZPos())
        end
    end

    mob:timer(30000, function(mobArg)
        for cloneId = mobId + 1, mobId + 4 do
            local clone = GetMobByID(cloneId)
            if clone then
                local cloneAction = clone:getCurrentAction()
                if cloneAction == xi.action.category.NONE then
                    return
                end

                if cloneAction == xi.action.category.DEATH then
                    return
                end

                DespawnMob(cloneId)
            end
        end
    end)

    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskillObject
