---------------------------------------------
-- Prishe Item 1
---------------------------------------------
local ID = require("scripts/zones/Empyreal_Paradox/IDs")
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    skill:setMsg(tpz.msg.basic.NONE)
    if (mob:getTarget() and mob:getTarget():getFamily() == 478) then
        -- using Ambrosia!
        target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 4511)
        mob:messageText(mob, ID.text.PRISHE_TEXT + 8, false)
    else
        -- using Daedalus Wing!
        mob:addTP(1000)
        mob:messageText(mob, ID.text.PRISHE_TEXT + 9, false)
    end
    return 0
end
