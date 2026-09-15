-----------------------------------
-- Substitute
-- Escapes the active target from the zone
-- This may be bugged on retail. None of the captured attempts teleported anyone.
-- JP wiki says a melee hit after the taunt can send the target to Xarcabard.
-- It also says Utsusemi can block Escape and pets are not affected.
-- Source: https://wiki.ffo.jp/html/15806.html
-- TODO: Check when Escape works, whether melee hits trigger it, and whether shadows block it.
-- TODO: Check the cast time, player animation, and what happens with pets and Trusts.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.msg.basic.NONE)

    if not target:isPC() then
        return
    end

    local partySize    = 0
    local targetZoneId = target:getZoneID()

    for _, member in ipairs(target:getParty()) do
        if member:getZoneID() == targetZoneId then
            partySize = partySize + 1
        end
    end

    if partySize == 1 then
        return
    end

    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.ESCAPE, duration = 3, origin = mob, icon = 0 })
end

return mobskillObject
