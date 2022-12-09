-----------------------------------
--  Optic Induration (Charge)
--
--  Description: Charges up a powerful, calcifying beam directed at targets in a fan-shaped area of effect. Additional effect: Petrification & enmity reset
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown cone
--  Notes: Charges up (three times) before actually being used (except Jailer of Temperance, who doesn't need to charge it up). The petrification lasts a very long time.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- Rarely used Optic Induration. Only charge if not an NM and in normal mode (no bars or rings)
    if mob:isNM() or mob:getAnimationSub() >= 2 or utils.chance(75) then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local chargeCount = mob:getLocalVar("chargeCount")
    if chargeCount == 0 then
        mob:setAutoAttackEnabled(false)
        mob:setLocalVar("chargeCount", 1)
        mob:setLocalVar("chargeTotal", math.random(3, 5))
        mob:timer(4000, function(mobArg)
            mob:useMobAbility(1464)
        end)
    else
        chargeCount = chargeCount + 1
        local chargeTotal = mob:getLocalVar("chargeTotal")
        if chargeCount == chargeTotal then
            mob:timer(4000, function(mobArg)
                mob:useMobAbility(1465, mob:getTarget())
            end)

            mob:timer(4500, function(mobArg)
                mob:setAutoAttackEnabled(true)
                mob:setLocalVar("chargeCount", 0)
                mob:setLocalVar("chargeTotal", 0)
            end)
        else
            mob:setLocalVar("chargeCount", chargeCount)
            mob:timer(4000, function(mobArg)
                mob:useMobAbility(1464)
            end)
        end
    end

    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskillObject
