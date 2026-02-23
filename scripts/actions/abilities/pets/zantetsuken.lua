-----------------------------------
-- Zantetsuken
-- Family: Odin (Player Pet)
-- Notes: Requires Astral Flow to be active.
-- TODO: Ability Needs captures/audit.
-- https://wiki.ffo.jp/html/17522.html

-- Wanna bet this is made up?
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    local returnParam = 0
    local power       = summoner:getMP() / utils.clamp(summoner:getMaxMP(), 1, 9999)

    if target:isNM() then
        local params = {}

        params.baseDamage      = power
        params.element         = xi.element.DARK
        params.attackType      = xi.attackType.MAGICAL
        params.damageType      = xi.damageType.DARK
        params.shadowBehavior  = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
        params.canMagicBurst   = true
        params.primaryMessage  = xi.msg.basic.USES_JA_TAKE_DAMAGE

        local info = xi.mobskills.mobMagicalMove(pet, target, petskill, action, params)

        if xi.mobskills.processDamage(pet, target, petskill, action, info) then
            target:takeDamage(info.damage, pet, info.attackType, info.damageType)
        end

        returnParam = info.damage
    else
        -- Insta-kill: Highly innacurate against regular monsters.
        local chance = 50 * power / utils.clamp(petskill:getTotalTargets(), 1, 50)

        if
            math.random(1, 100) <= chance and
            target:getAnimation() ~= 33
        then
            petskill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
            target:takeDamage(target:getHP(), pet, xi.attackType.MAGICAL, xi.damageType.DARK)

            returnParam = xi.effect.KO
        else
            petskill:setMsg(xi.msg.basic.EVADES)

            returnParam = 0
        end
    end

    summoner:setMP(0)

    return returnParam
end

return abilityObject
