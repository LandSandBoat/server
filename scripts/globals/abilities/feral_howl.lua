---------------------------------------------------
-- Ability: Feral Howl
-- Terrorizes the target.
-- Obtained: Beastmaster Level 75
-- Recast Time: 0:05:00
-- Duration: Apprx. 0:00:01 - 0:00:10
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local modAcc = player:getMerit(tpz.merit.FERAL_HOWL)
    --printf("modAcc : %u", modAcc)
    local feralHowlMod = player:getMod(tpz.mod.FERAL_HOWL_DURATION)
    --printf("feralHowlMod : %u", feralHowlMod)
        local duration = 10
    --printf("Duration : %u", duration)
    if target:hasStatusEffect(tpz.effect.TERROR) == true or target:hasStatusEffect(tpz.effect.STUN) == true then -- effect already on, or target stunned, do nothing
    -- reserved for miss based on target already having stun or terror effect active
    else
        -- Calculate duration.
        if feralHowlMod >= 1 then
            -- http://wiki.ffxiclopedia.org/wiki/Monster_Jackcoat_(Augmented)_%2B2
            -- add 20% duration per merit level if wearing Augmented Monster Jackcoat +2
            duration = (duration + (duration * modAcc * 0.04)) -- modAcc returns intervals of 5. (0.2 / 5 = 0.04)
            --printf("Duration post merit : %u", duration)
        end
    end

    -- Leaving potency at 1 since I am not sure it applies with this ability... no known way to increase resistance
    local potency = 1
    --printf("Potency : %u", potency)

    -- Grabbing variables for terror accuracy. Unknown if ability is stat based. Using Beastmaster's level versus Target's level
    local pLvl = player:getMainLvl()
    --printf("player level : %u", pLvl)
    local mLvl = target:getMainLvl()
    --printf("mob level : %u", mLvl)

    -- Checking level difference between the target and the BST
    local dLvl = (mLvl - pLvl)
    --printf("level difference : %u", dLvl)

    -- Determining what level of resistance the target will have to the ability
    local resist = 0
    dLvl = (10 * dLvl) - modAcc -- merits increase accuracy by 5% per level
    if dLvl <= 0 then -- default level difference to 1 if mob is equal to the Beastmaster's level or less.
        resist = 1
    --printf("resist : %u", resist)
    else
        resist = math.random(1, (dLvl + 100)) -- calculate chance of missing based on number of levels mob is higher than you. Target gets 10% resist per level over BST
    --printf("resist : %u", resist)
    end

    -- Adjusting duration based on resistance. Only fair way I could see to do it...
    if resist >= 20 then
        if (resist / 10) >= (duration) then
            duration = (duration - math.random(1, (duration - 2)))
            --printf("Duration post resist : %u", duration)
        else
            duration = (duration - math.random(1, (resist / 10)))
            --printf("Duration post resist : %u", duration)
        end
    end

    -- execute ability based off of resistance value space reserved for resist message
    if resist <= 90 then -- still experimental. not exactly sure how to calculate hit %
        target:addStatusEffect(tpz.effect.TERROR, potency, 0, duration)
    else
        -- reserved for text related to resist
    end

    return tpz.effect.TERROR
end
