-----------------------------------
-- Moonlight
-- Family: Humanoid Club Weaponskill
-- Description: Restores MP for party members in range. Amount restored varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local skillLevel   = mob:getMaxSkillLevel(math.min(mob:getMainLvl(), 99), mob:getMainJob(), xi.skill.CLUB) or 0 -- Calculate the max skill level for the mob level / job combination.
    local amount       = math.floor(((skillLevel / 9) - 1) * ((50 + (skill:getTP() * 0.05)) / 100))
    local partyMembers = mob:getParty()

    if not partyMembers then -- Party should always have at least 1 member, as it includes itself, but just in case.
        return 0
    end

    for _, member in ipairs(partyMembers) do
        if
            mob:checkDistance(member) <= 6 and
            member:isAlive()
        then
            member:addMP(amount)
        end
    end

    skill:setMsg(xi.msg.basic.SKILL_RECOVERS_MP)

    return amount
end

return mobskillObject
