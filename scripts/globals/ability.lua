-----------------------------------
-- ABILITIES
-----------------------------------
xi = xi or {}
xi.ability = xi.ability or {}

xi.ability.adjustDamage = function(dmg, mob, skill, target, skilltype, skillparam, shadowbehav) -- seems to only be used for Wyvern breaths
    -- physical attack missed, skip rest
    local msg = skill:getMsg()
    if
        msg == xi.msg.JA_MISS or
        msg == xi.msg.SKILL_MISS or
        msg == xi.msg.SHADOW_ABSORB or
        msg == xi.msg.ANTICIPATE
    then
        return 0
    end

    -- Handle pd.
    if
        (target:hasStatusEffect(xi.effect.PERFECT_DODGE) or
        target:hasStatusEffect(xi.effect.ALL_MISS)) and
        skilltype == xi.attackType.PHYSICAL
    then
        skill:setMsg(xi.msg.basic.JA_MISS_2)
        return 0
    end

    -- set message to damage
    -- this is for AoE because its only set once
    skill:setMsg(xi.msg.basic.USES_JA_TAKE_DAMAGE)

    -- Handle shadows depending on shadow behaviour / skilltype
    if
        shadowbehav ~= xi.mobskills.shadowBehavior.WIPE_SHADOWS and
        shadowbehav ~= xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    then
        --remove 'shadowbehav' shadows.

        dmg = utils.takeShadows(target, dmg, shadowbehav)

        -- dealt zero damage, so shadows took hit
        if dmg == 0 then
            skill:setMsg(xi.msg.basic.SHADOW_ABSORB)
            return shadowbehav
        end

    elseif shadowbehav == xi.mobskills.shadowBehavior.WIPE_SHADOWS then --take em all!
        target:delStatusEffect(xi.effect.COPY_IMAGE)
        target:delStatusEffect(xi.effect.BLINK)
        target:delStatusEffect(xi.effect.THIRD_EYE)
    end

    -- Handle Third Eye using shadowbehav as a guide.
    if
        (skilltype == xi.attackType.PHYSICAL or
        skilltype == xi.attackType.RANGED) and
        utils.thirdeye(target)
    then
        skill:setMsg(xi.msg.basic.ANTICIPATE)

        return 0
    end

    if skilltype == xi.attackType.PHYSICAL then
        dmg = target:physicalDmgTaken(dmg, skillparam)
    elseif skilltype == xi.attackType.MAGICAL then
        dmg = target:magicDmgTaken(dmg, skillparam)
    elseif skilltype == xi.attackType.BREATH then
        dmg = target:breathDmgTaken(dmg)
    elseif skilltype == xi.attackType.RANGED then
        dmg = target:rangedDmgTaken(dmg)
    end

    if dmg < 0 then
        return dmg
    end

    -- Handle Phalanx
    if dmg > 0 then
        dmg = utils.clamp(dmg - target:getMod(xi.mod.PHALANX), 0, 99999)
    end

    if skilltype == xi.attackType.MAGICAL then
        dmg = utils.oneforall(target, dmg)
    end

    dmg = utils.stoneskin(target, dmg)

    if dmg > 0 then
        target:wakeUp()
        target:updateEnmityFromDamage(mob, dmg)
    end

    return dmg
end

xi.ability.takeDamage = function(defender, attacker, params, primary, finaldmg, attackType, damageType, slot, tpHitsLanded, extraHitsLanded, shadowsAbsorbed, bonusTP, action, taChar)
    if tpHitsLanded + extraHitsLanded > 0 then
        if finaldmg >= 0 then
            if finaldmg > 0 then
                action:reaction(defender:getID(), xi.reaction.HIT)
                action:speceffect(defender:getID(), xi.specEffect.RECOIL)
            end
        else
            -- TODO: ability absorb messages (if there are any)
            -- action:messageID(defender:getID(), xi.msg.basic.WHATEVER)
        end

        action:param(defender:getID(), finaldmg)
    elseif shadowsAbsorbed > 0 then
        action:messageID(defender:getID(), xi.msg.basic.SHADOW_ABSORB)
        action:param(defender:getID(), shadowsAbsorbed)
    else
        -- no abilities that use ability message can miss (the rest use ws messages)
    end

    local targetTPMult = params.targetTPMult or 1
    finaldmg = defender:takeWeaponskillDamage(attacker, finaldmg, attackType, damageType, slot, primary, tpHitsLanded, (extraHitsLanded * 10) + bonusTP, targetTPMult)
    local enmityEntity = taChar or attacker
    if params.overrideCE and params.overrideVE then
        defender:addEnmity(enmityEntity, params.overrideCE, params.overrideVE)
    else
        local enmityMult = params.enmityMult or 1
        defender:updateEnmityFromDamage(enmityEntity, finaldmg * enmityMult)
    end

    return finaldmg
end
