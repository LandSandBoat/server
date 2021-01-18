---------------------------------------------
-- Metalid Body
--
-- Gives the effect of "Stoneskin."
-- Type: Magical
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local power = 25 -- ffxiclopedia claims its always 25 on the crabs page. Tested on wootzshell in mt zhayolm..
    --[[
    if (mob:isNM()) then
        power = ???  Betting NMs aren't 25 but I don't have data..
    end
    ]]
    skill:setMsg(MobBuffMove(mob, tpz.effect.STONESKIN, power, 0, 300))
    return tpz.effect.STONESKIN
end

return mobskill_object
