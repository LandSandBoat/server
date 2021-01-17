---------------------------------------------
-- Perfect Defense
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onPetAbility = function(target, pet, skill, master)
    local power = 100 * (master:getMP() / master:getMaxMP())
    duration = 60
    if (master ~= nil) then
        local summoningSkill = master:getSkillLevel(tpz.skill.SUMMONING_MAGIC)
        if (summoningSkill > 600) then
            summoningSkill = 600
        end
        duration = 30 + summoningSkill / 20
    end
    target:delStatusEffect(tpz.effect.PERFECT_DEFENSE)
    target:addStatusEffect(tpz.effect.PERFECT_DEFENSE, power, 3, duration)
    skill:setMsg(tpz.msg.basic.SKILL_GAIN_EFFECT)
    master:setMP(0)
    return tpz.effect.PERFECT_DEFENSE
end

return ability_object
