-----------------------------------
-- Dancer Job Utilities
-----------------------------------
require('scripts/globals/jobpoints')
require('scripts/globals/magic')
require('scripts/globals/msg')
require('scripts/globals/status')
require('scripts/globals/weaponskills')
-----------------------------------
xi = xi or {}
xi.job_utils = xi.job_utils or {}
xi.job_utils.dancer = xi.job_utils.dancer or {}
-----------------------------------

local function getMaxFinishingMoves(player)
    return 5 + player:getMod(xi.mod.MAX_FINISHING_MOVE_BONUS)
end

-- This function returns the default number of finishing moves awarded.  Expand this
-- function as needed.

-- TODO: Determine if step is stacked at 10, and reduce to 1 if necessary.
local function getStepFinishingMovesBase(player)
    local numAwardedMoves = 1

    if player:hasStatusEffect(xi.effect.PRESTO) then
        numAwardedMoves = 5
    elseif player:getMainJob() == xi.job.DNC then
        numAwardedMoves = 2
    end

    return numAwardedMoves
end

-- When a finishing move effect wears for the player, it is always Finishing Move 1.  In this case,
-- use FM1 to track via power, and update icon as necessary (6 being the 5+).
local function getFinishingMoveIcon(numMoves)
    local effectIconId = xi.effect.FINISHING_MOVE_1

    if numMoves < 1 then
        return nil
    end

    if numMoves <= 5 then
        effectIconId = effectIconId + numMoves - 1
    else
        effectIconId = xi.effect.FINISHING_MOVE_6
    end

    return effectIconId
end

local function setFinishingMoves(player, numMoves)
    local finishingEffect = player:getStatusEffect(xi.effect.FINISHING_MOVE_1)

    if finishingEffect then
        if numMoves == 0 then
            player:delStatusEffect(xi.effect.FINISHING_MOVE_1)
            return
        else
            player:delStatusEffectSilent(xi.effect.FINISHING_MOVE_1)
        end
    end

    numMoves = math.min(numMoves, getMaxFinishingMoves(player))
    player:addStatusEffectEx(xi.effect.FINISHING_MOVE_1, getFinishingMoveIcon(numMoves), numMoves, 0, 7200)
end

xi.job_utils.dancer.stepAbilityCheck = function(player, target, ability)
    if player:getAnimation() ~= 1 then
        return xi.msg.basic.REQUIRES_COMBAT, 0
    else
        if player:hasStatusEffect(xi.effect.TRANCE) then
            return 0, 0
        elseif player:getTP() < 100 then
            return xi.msg.basic.NOT_ENOUGH_TP, 0
        else
            return 0, 0
        end
    end
end

xi.job_utils.dancer.useStepAbility = function(player, target, ability, action, stepEffect, missId, hitId)
    local hitType          = missId
    local stepDurationGift = player:getJobPointLevel(xi.jp.STEP_DURATION)
    local debuffStacks     = 1
    local debuffDuration   = 60 + stepDurationGift

    -- Only remove TP if the player doesn't have Trance.
    if not player:hasStatusEffect(xi.effect.TRANCE) then
        player:delTP(100)
    end

    if math.random() <= getHitRate(player, target, true, player:getMod(xi.mod.STEP_ACCURACY)) then
        local debuffEffect = target:getStatusEffect(stepEffect)
        hitType            = hitId

        -- Handle Target Debuffs
        if debuffEffect then
            debuffStacks   = debuffEffect:getPower()
            debuffDuration = debuffEffect:getDuration()

            if player:hasStatusEffect(xi.effect.PRESTO) then
                debuffStacks = debuffStacks + 5
                player:delStatusEffect(xi.effect.PRESTO)
            else
                debuffStacks = debuffStacks + 1
            end

            debuffStacks   = math.min(debuffStacks, 10)
            debuffDuration = math.min(debuffEffect:getDuration() + 30 + stepDurationGift, 120 + stepDurationGift)

            target:delStatusEffectSilent(stepEffect)
        end

        target:addStatusEffect(stepEffect, debuffStacks, 0, debuffDuration)

        -- Apply Finishing Moves
        local fmEffect   = player:getStatusEffect(xi.effect.FINISHING_MOVE_1)
        local addedMoves = getStepFinishingMovesBase(player)

        if fmEffect then
            addedMoves = addedMoves + fmEffect:getPower()
        end

        setFinishingMoves(player, math.min(addedMoves, getMaxFinishingMoves(player)))
    else
        ability:setMsg(xi.msg.basic.JA_MISS)
    end

    action:setAnimation(target:getID(), getStepAnimation(player:getWeaponSkillType(xi.slot.MAIN)))

    -- Overrides for Trusts
    if player:getObjType() == xi.objType.TRUST then
        -- TODO: Is there a better way to handle this that doesn't involve
        -- embedding a weapon type to the trust object?

        local name = string.lower(player:getName())
        if name == "uka_totlihn" or name == "mumor" or name == "mumor_ii" then
            action:setAnimation(target:getID(), getStepAnimation(xi.skill.CLUB))
        elseif name == "mayakov" then
            action:setAnimation(target:getID(), getStepAnimation(xi.skill.SWORD))
        end
    end

    action:speceffect(target:getID(), hitType)

    return debuffStacks
end

xi.job_utils.dancer.usePrestoAbility = function(player, target, ability, action)
    target:addStatusEffect(xi.effect.PRESTO, 19, 1, 30)
end

xi.job_utils.dancer.checkNoFootRiseAbility = function(player, target, ability)
    local fmEffect = player:getStatusEffect(xi.effect.FINISHING_MOVE_1)

    if
        fmEffect and
        fmEffect:getPower() >= getMaxFinishingMoves(player)
    then
        return 561, 0
    else
        return 0, 0
    end
end

xi.job_utils.dancer.useNoFootRiseAbility = function(player, target, ability, action)
    local addedMoves = player:getMerit(xi.merit.NO_FOOT_RISE)
    local fmEffect   = player:getStatusEffect(xi.effect.FINISHING_MOVE_1)

    if fmEffect then
        addedMoves = addedMoves + fmEffect:getPower()
    end

    addedMoves = math.min(addedMoves, getMaxFinishingMoves(player))
    setFinishingMoves(player, addedMoves)

    return addedMoves
end

xi.job_utils.dancer.checkReverseFlourishAbility = function(player, target, ability)
    if player:hasStatusEffect(xi.effect.FINISHING_MOVE_1) then
        return 0, 0
    else
        return xi.msg.basic.NO_FINISHINGMOVES, 0
    end
end

xi.job_utils.dancer.useReverseFlourishAbility = function(player, target, ability, action)
    local reverseFlourishBonus = player:getJobPointLevel(xi.jp.FLOURISH_II_EFFECT)
    local numMerits            = player:getMerit(xi.merit.REVERSE_FLOURISH_EFFECT)
    local gearMod              = player:getMod(xi.mod.REVERSE_FLOURISH_EFFECT)
    local numMoves             = player:getStatusEffect(xi.effect.FINISHING_MOVE_1):getPower()
    local tpGained             = 0

    local usedMoves = math.min(numMoves, 5)
    tpGained = (95 + reverseFlourishBonus) * usedMoves + (5 + gearMod) * usedMoves ^ 2 + 30 * numMerits

    player:addTP(tpGained)
    setFinishingMoves(player, numMoves - usedMoves)

    return tpGained
end

xi.job_utils.dancer.checkAnimatedFlourishAbility = function(player, target, ability)
    if player:hasStatusEffect(xi.effect.FINISHING_MOVE_1) then
        return 0, 0
    else
        return xi.msg.basic.NO_FINISHINGMOVES, 0
    end
end

xi.job_utils.dancer.useAnimatedFlourishAbility = function(player, target, ability, action)
    local jpBonusVE = player:getJobPointLevel(xi.jp.FLOURISH_I_EFFECT) * 10
    local numMoves  = player:getStatusEffect(xi.effect.FINISHING_MOVE_1):getPower()
    local veGranted = numMoves >= 2 and 1500 or 1000
    local usedMoves = numMoves >= 2 and 2 or 1

    target:addEnmity(player, 0, veGranted + jpBonusVE)
    setFinishingMoves(player, numMoves - usedMoves)
end

xi.job_utils.dancer.checkDesperateFlourishAbility = function(player, target, ability)
    if player:getAnimation() ~= 1 then
        return xi.msg.basic.REQUIRES_COMBAT, 0
    else
        if player:hasStatusEffect(xi.effect.FINISHING_MOVE_1) then
            return 0, 0
        else
            return xi.msg.basic.NO_FINISHINGMOVES, 0
        end
    end
end

xi.job_utils.dancer.useDesperateFlourishAbility = function(player, target, ability, action)
    local numMoves = player:getStatusEffect(xi.effect.FINISHING_MOVE_1):getPower()

    setFinishingMoves(player, numMoves - 1)

    if
        math.random() <= getHitRate(player, target, true, player:getJobPointLevel(xi.jp.FLOURISH_I_EFFECT)) or
        (player:hasStatusEffect(xi.effect.SNEAK_ATTACK) and player:isBehind(target))
    then
        local spell  = GetSpell(xi.magic.spell.GRAVITY)
        local params =
        {
            diff      = 0,
            skillType = player:getWeaponSkillType(xi.slot.MAIN),
            bonus     = 50 - target:getMod(xi.mod.GRAVITYRES),
        }

        local resistRate = applyResistance(player, target, spell, params)
        if resistRate > 0.25 then
            target:delStatusEffectSilent(xi.effect.WEIGHT)
            target:addStatusEffect(xi.effect.WEIGHT, 50, 0, 60 * resistRate)
        else
            ability:setMsg(xi.msg.basic.JA_DAMAGE)
        end

        ability:setMsg(xi.msg.basic.JA_ENFEEB_IS)
        action:setAnimation(target:getID(), getFlourishAnimation(player:getWeaponSkillType(xi.slot.MAIN)))
        action:speceffect(target:getID(), 2)

        return xi.effect.WEIGHT
    else
        ability:setMsg(xi.msg.basic.JA_MISS)
        return 0
    end
end

xi.job_utils.dancer.checkViolentFlourishAbility = function(player, target, ability)
    if player:getAnimation() ~= 1 then
        return xi.msg.basic.REQUIRES_COMBAT, 0
    else
        if player:hasStatusEffect(xi.effect.FINISHING_MOVE_1) then
            return 0, 0
        else
            return xi.msg.basic.NO_FINISHINGMOVES, 0
        end
    end
end

-- TODO: This ability needs verification
xi.job_utils.dancer.useViolentFlourishAbility = function(player, target, ability, action)
    local numMoves = player:getStatusEffect(xi.effect.FINISHING_MOVE_1):getPower()

    setFinishingMoves(player, numMoves - 1)

    if
        math.random() <= getHitRate(player, target, true, 100) or
        (player:hasStatusEffect(xi.effect.SNEAK_ATTACK) and player:isBehind(target))
    then
        local hitType = 3
        local spell   = GetSpell(xi.magic.spell.STUN)
        local params  =
        {
            atk100    = 1,
            atk200    = 1,
            atk300    = 1,
            diff      = 0,
            skillType = player:getWeaponSkillType(xi.slot.MAIN),
            bonus     = 50 - target:getMod(xi.mod.STUNRES) + player:getMod(xi.mod.VFLOURISH_MACC) + player:getJobPointLevel(xi.jp.FLOURISH_I_EFFECT),
        }

        -- Apply WSC
        local weaponDamage = player:getWeaponDmg()
        if player:getWeaponSkillType(xi.slot.MAIN) == xi.skill.HAND_TO_HAND then
            local h2hSkill = player:getSkillLevel(xi.skill.HAND_TO_HAND) * 0.11 + 3

            weaponDamage = weaponDamage - 3 + h2hSkill
        end

        local baseDmg   = weaponDamage + fSTR(player:getStat(xi.mod.STR), target:getStat(xi.mod.VIT), player:getWeaponDmgRank())
        local cRatio, _ = cMeleeRatio(player, target, params, 0, 0)
        local dmg       = baseDmg * generatePdif(cRatio[1], cRatio[2], true)

        if applyResistance(player, target, spell, params) > 0.25 then
            target:addStatusEffect(xi.effect.STUN, 1, 0, 2)
        else
            ability:setMsg(xi.msg.basic.JA_DAMAGE)
        end

        dmg = utils.stoneskin(target, dmg)
        target:takeDamage(dmg, player, xi.attackType.PHYSICAL, player:getWeaponDamageType(xi.slot.MAIN))
        target:updateEnmityFromDamage(player, dmg)

        action:setAnimation(target:getID(), getFlourishAnimation(player:getWeaponSkillType(xi.slot.MAIN)))
        action:speceffect(target:getID(), hitType)

        return dmg
    else
        ability:setMsg(xi.msg.basic.JA_MISS)
        return 0
    end
end
