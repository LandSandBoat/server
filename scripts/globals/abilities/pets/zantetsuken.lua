-----------------------------------
-- Zantetsuken
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill, master)
    local power = master:getMP() / master:getMaxMP()
    master:setMP(0)

    if target:isNM() then
        local dmg = 0.1 * target:getHP() + 0.1 * target:getHP() * power
        if dmg > 9999 then
            dmg = 9999
        end

        dmg = xi.mobskills.mobMagicalMove(pet, target, skill, dmg, xi.magic.ele.DARK, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0)
        dmg = xi.mobskills.mobAddBonuses(pet, target, dmg.dmg, xi.magic.ele.DARK)
        dmg = xi.summon.avatarFinalAdjustments(dmg, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, 1)
        target:takeDamage(dmg, pet, xi.attackType.MAGICAL, xi.damageType.DARK)
        target:updateEnmityFromDamage(pet, dmg)
        return dmg
    else
        local chance = (100 * power) / skill:getTotalTargets()
        if math.random(0, 99) < chance and target:getAnimation() ~= 33 then
            skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
            target:takeDamage(target:getHP(), pet, xi.attackType.MAGICAL, xi.damageType.DARK)
            return xi.effect.KO
        else
            skill:setMsg(xi.msg.basic.EVADES)
            return 0
        end
    end
end

return abilityObject
