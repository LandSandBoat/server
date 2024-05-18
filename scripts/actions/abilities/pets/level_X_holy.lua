-----------------------------------
-- Level X Holy
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)
    local holyRollOneAnimID = 164
    local primaryTargetID = action:getPrimaryTargetID()

    -- If primary target, roll for power by setting random animation.
    if primaryTargetID == target:getID() then
        action:setAnimation(primaryTargetID, holyRollOneAnimID + math.random(0, 5))
    else
        action:setAnimation(target:getID(), action:getAnimation(primaryTargetID))
    end

    local power = action:getAnimation(target:getID()) - holyRollOneAnimID + 1
    local dMND = math.floor(pet:getStat(xi.mod.MND) - target:getStat(xi.mod.MND))
    local ele = xi.element.LIGHT
    local dmg = 0

    local dmgmod = 1
    local basedmg = pet:getMainLvl() * power + (dMND * 1.5)
    -- Only have an effect if target's level is divisible by die roll
    if target:getMainLvl() % power == 0 then
        local info = xi.mobskills.mobMagicalMove(pet, target, petskill, basedmg, ele, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 10)
        dmg = xi.mobskills.mobAddBonuses(pet, target, info.dmg, ele, petskill)
        dmg = xi.summon.avatarFinalAdjustments(dmg, pet, petskill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, 1)

        -- TODO: Magic burst?

        target:takeDamage(dmg, pet, xi.attackType.MAGICAL, ele)
        target:updateEnmityFromDamage(pet, dmg)
    else
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
    end

    return dmg
end

return abilityObject
