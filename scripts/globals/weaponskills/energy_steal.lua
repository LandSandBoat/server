-----------------------------------
-- Energy Steal
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
require("scripts/globals/msg")
-----------------------------------
local weaponskillObject = {}

-- https://www.bg-wiki.com/ffxi/Energy_Steal
weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local fTPAnchors = { 1.0, 2.1, 3.4 }

    local startingAnchor = math.floor(tp / 1000)

    local multiplier = 0

    if tp >= 3000 then
        multiplier = fTPAnchors[3]
    else
        local basefTP   = fTPAnchors[startingAnchor]
        local nextfTP   = fTPAnchors[startingAnchor + 1]
        local multPerTP = (nextfTP - basefTP) / 1000 * (tp - 1000 * startingAnchor)
        -- TP = 1250; multiplier = 1.0 + ( (2.1 - 1.0) / 1000 * (1250 - (1000 * 1))
        --            multiplier = 1.0 + (1.0 / 1000) * 250)
        --            multiplier = 1.0 + 0.275 = 1.275
        multiplier = basefTP + multPerTP
    end

    local skill = player:getSkillLevel(xi.skill.DAGGER)
    local wsc   = player:getStat(xi.mod.MND) * 1.0

    local mpRestored = math.floor((math.floor(skill * 0.11) + wsc) * multiplier)

    if target:isUndead() then
        mpRestored = 0
    else
        -- Absorb MP from target
        mpRestored = target:delMP(mpRestored)

        -- Add stolen MP to player
        mpRestored = player:addMP(mpRestored)
    end

    -- Display MP actually given to player
    action:messageID(target:getID(), xi.msg.basic.SKILL_DRAIN_MP)
    action:param(target:getID(), mpRestored)

    return 1, 0, false, mpRestored
end

return weaponskillObject
