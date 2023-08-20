-----------------------------------
-- Summonshadows
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local zeidId = mob:getID()
    local shadowOne = GetMobByID(zeidId + 1)
    local shadowTwo = GetMobByID(zeidId + 2)

    if not shadowOne:isSpawned() and not shadowTwo:isSpawned() then
        local xPos = mob:getXPos()
        local yPos = mob:getYPos()
        local zPos = mob:getZPos()

        shadowOne:spawn()
        shadowTwo:spawn()
        shadowOne:setPos(xPos, yPos, zPos)
        shadowTwo:setPos(xPos, yPos, zPos)
        shadowOne:updateEnmity(target)
        shadowTwo:updateEnmity(target)
    end

    skill:setMsg(xi.msg.basic.NONE)

    return 0
end

return mobskillObject
