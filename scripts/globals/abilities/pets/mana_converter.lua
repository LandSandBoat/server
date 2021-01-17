---------------------------------------------
-- Mana Converter
---------------------------------------------
require("scripts/globals/automatonweaponskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------
local ability_object = {}

function onMobSkillCheck(target, automaton, skill)
    return 0
end

ability_object.onPetAbility = function(target, automaton, skill, master, action)
    automaton:addRecast(tpz.recast.ABILITY, skill:getID(), 180)
    local hp = target:getHP()
    local duration = 30
    local amount = math.floor((hp/2)/10)
    local difference = math.ceil(hp/2 - (amount*10))
    skill:setMsg(tpz.msg.basic.SKILL_GAIN_EFFECT)

    target:addMP(difference) -- To prevent possible loss of MP from flooring the refresh
    target:setHP(math.floor(hp/2))
    target:delStatusEffect(tpz.effect.REFRESH)
    target:addStatusEffect(tpz.effect.REFRESH, amount, 3, duration)

    return tpz.effect.REFRESH
end

return ability_object
