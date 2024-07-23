-----------------------------------
-- Zantetsuken
-- Wanna bet this is made up?
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, skill, summoner, action)
    local returnParam = 0

    local power = summoner:getMP() / utils.clamp(summoner:getMaxMP(), 1, 9999)
    summoner:setMP(0)

    -- Damage
    if target:isNM() then
        local dmg = (target:getHP() + target:getHP() * power) / 10

        if dmg > 9999 then
            dmg = 9999
        end

        dmg = xi.mobskills.mobMagicalMove(pet, target, skill, dmg, xi.element.DARK, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0)
        dmg = xi.mobskills.mobAddBonuses(pet, target, dmg, xi.element.DARK, skill)
        dmg = xi.summon.avatarFinalAdjustments(dmg, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, 1)

        target:takeDamage(dmg, pet, xi.attackType.MAGICAL, xi.damageType.DARK)
        target:updateEnmityFromDamage(pet, dmg)

        returnParam = dmg

    -- Insta-kill: Highly innacurate against regular monsters.
    else
        local chance = 50 * power / utils.clamp(skill:getTotalTargets(), 1, 50)

        if
            math.random(1, 100) <= chance and
            target:getAnimation() ~= 33
        then
            skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
            target:takeDamage(target:getHP(), pet, xi.attackType.MAGICAL, xi.damageType.DARK)

            returnParam = xi.effect.KO
        else
            skill:setMsg(xi.msg.basic.EVADES)

            returnParam = 0
        end
    end

    return returnParam
end

return abilityObject
