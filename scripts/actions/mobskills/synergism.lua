-----------------------------------
-- Synergism
-- Family: Flan
-- Description: Steals HP from any nearby flans.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    if target:getID() == mob:getID() then
        local absorbed = 0
        local count = skill:getTotalTargets() - 1  -- Do not include self
        if count > 0 then
            -- Get 50% of the missing HP that is the target amount to steal from nearby Flans
            local percentage = (100 - skill:getMobHPP()) / 200
            local targetAmount = (mob:getMaxHP() * percentage) / count
            for _, skillTarget in pairs(skill:getTargets()) do
                if skillTarget:getID() ~= mob:getID() then
                    local amount = math.min(targetAmount, skillTarget:getHP() - 1)
                    skillTarget:takeDamage(amount)
                    absorbed = absorbed + amount
                end
            end

            local params = {}

            params.baseHeal = absorbed
            params.fTP =
            {
                { tp = 1000, modifier = 1.00 },
                { tp = 2000, modifier = 1.00 },
                { tp = 3000, modifier = 1.00 },
            }

            xi.mobskills.mobHealMove(mob, target, skill, action, params)
        end
    end

    skill:setMsg(xi.msg.basic.NONE)

    return 0
end

return mobskillObject
