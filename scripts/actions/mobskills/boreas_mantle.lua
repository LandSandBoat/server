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

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local mobID = mob:getID()
    local player = mob:getTarget()
    local clonehp = 500
    local hpp = mob:getHPP() / 100.0
    local maxhp = math.ceil(clonehp / hpp)
    for cloneID = mobID + 1, mobID + 4 do
        local clone = SpawnMob(cloneID)
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
        for cloneID = mobID + 1, mobID + 4 do
            local clone = GetMobByID(cloneID)
            if clone then
                local action = clone:getCurrentAction()
                if action ~= xi.act.NONE and action ~= xi.act.DEATH then
                    DespawnMob(cloneID)
                end
            end
        end
    end)

    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskillObject
