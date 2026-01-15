-----------------------------------
-- Reward (mob skill)
-- Description : Heals the masters pet to full HP.
-- Used by: Percipient Zoraal Ja in Wajaom Woodlands
-----------------------------------

---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local pet = mob:getPet()

    if not pet then
        return
    end

    pet:setHP(pet:getMaxHP()) -- No heal message displayed in log, but pet was healed to full HP both times
    skill:setMsg(xi.msg.basic.USES)
end

return mobskillObject
