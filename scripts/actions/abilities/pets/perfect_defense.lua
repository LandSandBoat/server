-----------------------------------
-- Perfect Defense
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill, master, action)
    if master == nil then
        return 0
    end

    local power    = master:getLocalVar('perfectDefPower')

    if power == 0 then
        power = 9000 * (master:getMP() / master:getMaxMP())
        master:setLocalVar('perfectDefPower', power)
        master:setMP(0)
        master:delStatusEffect(xi.effect.ASTRAL_FLOW)
    end

    local summoningSkill = master:getSkillLevel(xi.skill.SUMMONING_MAGIC)
    if summoningSkill > 600 then
        summoningSkill = 600
    end

    local duration = 30 + summoningSkill / 20
    local subPower = math.floor(98 * power / 9000)

    target:delStatusEffect(xi.effect.PERFECT_DEFENSE)
    target:addStatusEffect(xi.effect.PERFECT_DEFENSE, power, 3, duration, 0, subPower)

    -- Despawn Alexander after 6 seconds.
    pet:timer(6000, function()
        if master then
            master:setLocalVar('perfectDefPower', 0)
            master:despawnPet()
        end
    end)

    if target:getID() == action:getPrimaryTargetID() then
        skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT_2)
    else
        skill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
    end

    return xi.effect.PERFECT_DEFENSE
end

return abilityObject
