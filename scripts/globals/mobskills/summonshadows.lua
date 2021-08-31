-----------------------------------
-- Summonshadows
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 1
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local zeidId = mob:getID()
    local shadowOne = GetMobByID(zeidId + 1)
    local shadowTwo = GetMobByID(zeidId + 2)

    if not shadowOne:isSpawned() and not shadowTwo:isSpawned() then
        local X = mob:getXPos()
        local Y = mob:getYPos()
        local Z = mob:getZPos()

        shadowOne:spawn()
        shadowTwo:spawn()
        shadowOne:setPos(X, Y, Z)
        shadowTwo:setPos(X, Y, Z)
        shadowOne:updateEnmity(target)
        shadowTwo:updateEnmity(target)
    end

    skill:setMsg(xi.msg.basic.NONE)

    return 0
end

return mobskill_object
