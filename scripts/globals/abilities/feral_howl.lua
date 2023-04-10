-----------------------------------
-- Ability: Feral Howl
-- Terrorizes the target.
-- Obtained: Beastmaster Level 75
-- Recast Time: 0:05:00
-- Duration: Apprx. 0:00:01 - 0:00:10
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    local modAcc       = player:getMerit(xi.merit.FERAL_HOWL)
    local feralHowlMod = player:getMod(xi.mod.FERAL_HOWL_DURATION)
    local duration     = 10

    if
        target:hasStatusEffect(xi.effect.TERROR) or
        target:hasStatusEffect(xi.effect.STUN)
    then
        -- effect already on, or target stunned, do nothing
        -- reserved for miss based on target already having stun or terror effect active
    else
        -- Calculate duration.
        if feralHowlMod >= 1 then
            -- http://wiki.ffxiclopedia.org/wiki/Monster_Jackcoat_(Augmented)_%2B2
            -- add 20% duration per merit level if wearing Augmented Monster Jackcoat +2
            duration = duration + (duration * modAcc * 0.04) -- modAcc returns intervals of 5. (0.2 / 5 = 0.04)
        end
    end

    -- Leaving potency at 1 since I am not sure it applies with this ability. No known way to increase resistance
    local potency = 1

    -- Grabbing variables for terror accuracy. Unknown if ability is stat based. Using Beastmaster's level versus Target's level
    local pLvl = player:getMainLvl()
    local mLvl = target:getMainLvl()

    -- Checking level difference between the target and the BST
    local dLvl = mLvl - pLvl

    -- Determining what level of resistance the target will have to the ability
    local resist = 0
    dLvl         = (10 * dLvl) - modAcc -- merits increase accuracy by 5% per level

    if dLvl <= 0 then -- default level difference to 1 if mob is equal to the Beastmaster's level or less.
        resist = 1
    else
        resist = math.random(1, (dLvl + 100)) -- calculate chance of missing based on number of levels mob is higher than you. Target gets 10% resist per level over BST
    end

    -- Adjusting duration based on resistance.
    if resist >= 20 then
        if resist / 10 >= duration then
            duration = duration - math.random(1, (duration - 2))
        else
            duration = duration - math.random(1, (resist / 10))
        end
    end

    -- execute ability based off of resistance value space reserved for resist message
    if resist <= 90 then -- still experimental. not exactly sure how to calculate hit %
        target:addStatusEffect(xi.effect.TERROR, potency, 0, duration)
    else
        -- reserved for text related to resist
    end

    return xi.effect.TERROR
end

return abilityObject
