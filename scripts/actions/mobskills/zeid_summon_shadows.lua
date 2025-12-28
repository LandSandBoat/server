-----------------------------------
-- Summonshadows
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local zeidId = mob:getID()
    local shadowOne = GetMobByID(zeidId + 1)
    local shadowTwo = GetMobByID(zeidId + 2)

    if
        shadowOne and
        shadowTwo and
        not shadowOne:isSpawned() and
        not shadowTwo:isSpawned()
    then
        local xPos = mob:getXPos()
        local yPos = mob:getYPos()
        local zPos = mob:getZPos()

        shadowOne:spawn()
        shadowTwo:spawn()
        shadowOne:setPos(xPos + math.random(-2, 2), yPos, zPos + math.random(-2, 2))
        shadowTwo:setPos(xPos + math.random(-2, 2), yPos, zPos + math.random(-2, 2))
        shadowOne:updateEnmity(target)
        shadowTwo:updateEnmity(target)
    end

    skill:setMsg(xi.msg.basic.NONE)

    return 0
end

return mobskillObject
