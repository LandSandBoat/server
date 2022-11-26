-----------------------------------
-- Dancer Job Utilities
-----------------------------------
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

-- TODO: This might be able to become generic
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

xi.job_utils.dancer.usePrestoAbility = function(player, target, ability)
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

xi.job_utils.dancer.useNoFootRiseAbility = function(player, target, ability)
    local addedMoves = player:getMerit(xi.merit.NO_FOOT_RISE)
    local fmEffect   = player:getStatusEffect(xi.effect.FINISHING_MOVE_1)

    if fmEffect then
        addedMoves = addedMoves + fmEffect:getPower()
    end

    addedMoves = math.min(addedMoves, getMaxFinishingMoves(player))
    setFinishingMoves(player, addedMoves)

    return addedMoves
end
