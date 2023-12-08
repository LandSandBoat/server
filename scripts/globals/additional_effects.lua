-----------------------------------
-- This global is intended to handle additional effects from item sources of:
-- melee attacks, ranged attacks, auto-spikes
-- Notes:
-- Ranged versions get bonus from int/mnd, melee does NOT.
-- No matter how much INT you stack that fire sword doesn't hit any harder.
-- No matter how much MND you stack that holy mace doesn't hit any harder.
-- But Ice Arrows and Bloody Bolts will gain damage from INT and Holy bolts will gain damage from MND.
-- Melee weapon proc also do not appear to adjust for level, only resistance.
-- In testing my fire sword had the same damage ranges no matter my level vs same mob.
-- Weakness/resistance to element would swing damage range a lot
-- For status effects is it possible to land on highly resistant mobs because of flooring.
-----------------------------------
require('scripts/globals/teleports') -- For warp weapon proc.
require('scripts/globals/magic') -- For resist functions
require('scripts/globals/utils') -- For clamping function
-----------------------------------
xi = xi or {}
xi.additionalEffect = xi.additionalEffect or {}

xi.additionalEffect.isRanged = function(item)
    -- Archery/Marksmanship/Throwing
    return math.abs(item:getSkillType() - xi.skill.MARKSMANSHIP) < 2
end

xi.additionalEffect.calcRangeBonus = function(attacker, defender, element, damage)
    -- Copied from existing scripts. Todo: rework into additional modifier for dStat?
    local bonus = 0

    if element == xi.element.LIGHT then
        bonus = attacker:getStat(xi.mod.MND) - defender:getStat(xi.mod.MND)
        if bonus > 40 then
            bonus = bonus + (bonus - 40) / 2
            damage = damage + bonus
        end
    else
        bonus = attacker:getStat(xi.mod.INT) - defender:getStat(xi.mod.INT)
        if bonus > 20 then
            bonus = bonus + (bonus -20) / 2
            damage = damage + bonus
        end
    end

    return damage
end

xi.additionalEffect.levelCorrection = function(dLV, aLV, chance)
    -- Level correction of proc chance (copied from existing bolt/arrow scripts, looks wrong..)
    if dLV > aLV then
        chance = utils.clamp(chance - 5 * (dLV - aLV), 5, 95)
    end

    return chance
end

xi.additionalEffect.statusAttack = function(addStatus, defender)
    local effectList =
    {
        [xi.effect.DEFENSE_DOWN] = { tick = 0, strip = xi.effect.DEFENSE_BOOST },
        [xi.effect.EVASION_DOWN] = { tick = 0, strip = xi.effect.EVASION_BOOST },
        [xi.effect.ATTACK_DOWN]  = { tick = 0, strip = xi.effect.ATTACK_BOOST },
        [xi.effect.POISON]       = { tick = 3, strip = nil },
        [xi.effect.CHOKE]        = { tick = 3, strip = nil },
    }

    local effect = effectList[addStatus]
    if effect then
        if effect.strip then
            defender:delStatusEffect(effect.strip)
        end

        return effect.tick
    end

    return 0
end

xi.additionalEffect.calcDamage = function(attacker, element, defender, damage)
    local params = {}

    params.bonusmab   = 0
    params.includemab = false
    damage            = addBonusesAbility(attacker, element, defender, damage, params)
    damage            = damage * applyResistanceAddEffect(attacker, defender, element, 0)
    damage            = adjustForTarget(defender, damage, element)
    damage            = finalMagicNonSpellAdjustments(attacker, defender, element, damage)

    --[[
    This should rightly be modified by resistance checks, and while those DO they are presently not perfect.
    If you want to force some randomness, un-comment the line below to artificially force 20% variance.
    ]]
    -- damage = damage * (math.random(90, 110) / 100)

    return damage
end

-- paralyze on hit, fire damage on hit, etc.
-- Disable cyclomatic complexity check for this function:
-- luacheck: ignore 561
-- TODO: Reduce complexity in this function:
-- - replace giant if/else chain with table+key functions
--   e.g. [procType.DAMAGE] = { code }
-- - replace each handler (elseif addType == procType.DEBUFF then) with a function
xi.additionalEffect.attack = function(attacker, defender, baseAttackDamage, item)
    local addType   = item:getMod(xi.mod.ITEM_ADDEFFECT_TYPE)
    local subEffect = item:getMod(xi.mod.ITEM_SUBEFFECT)
    local damage    = item:getMod(xi.mod.ITEM_ADDEFFECT_DMG)
    local chance    = item:getMod(xi.mod.ITEM_ADDEFFECT_CHANCE)
    local element   = item:getMod(xi.mod.ITEM_ADDEFFECT_ELEMENT)
    local addStatus = item:getMod(xi.mod.ITEM_ADDEFFECT_STATUS)
    local power     = item:getMod(xi.mod.ITEM_ADDEFFECT_POWER)
    local duration  = item:getMod(xi.mod.ITEM_ADDEFFECT_DURATION)
    local msgID     = 0
    local msgParam  = 0
    local drainRoll = math.random(1, 3) -- Temp, being refactored out

    local procType =
    {
        -- These are arbitrary, make up new ones as needed.
        DAMAGE        = 1,
        DEBUFF        = 2,
        HP_HEAL       = 3,
        MP_HEAL       = 4,
        HP_DRAIN      = 5,
        MP_DRAIN      = 6,
        TP_DRAIN      = 7,
        HPMP_DRAIN    = 8,
        HPMPTP_DRAIN  = 9,
        DISPEL        = 10,
        ABSORB_STATUS = 11,
        SELF_BUFF     = 12,
        DEATH         = 13,
    }

    -- If player is level synced below the level of the item, do no proc
    if item:getReqLvl() > attacker:getMainLvl() then
        return 0, 0, 0
    end

    -- If we're not going to proc, lets not execute all those checks!
    if math.random(1, 100) > chance then
        return 0, 0, 0
    end

    -- Modifications for proc's sourced from ranged attacks. See notes at top of script.
    if xi.additionalEffect.isRanged(item) then
        if element then
            damage = xi.additionalEffect.calcRangeBonus(attacker, defender, element, damage)
        end

        chance = xi.additionalEffect.levelCorrection(defender:getMainLvl(), attacker:getMainLvl(), chance)
    end

    if addType == procType.DAMAGE then
        damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage)
        msgID  = xi.msg.basic.ADD_EFFECT_DMG

        if damage < 0 then
            msgID = xi.msg.basic.ADD_EFFECT_HEAL
        end

        msgParam = damage

    elseif addType == procType.DEBUFF then
        if addStatus and addStatus > 0 then
            local tick = xi.additionalEffect.statusAttack(addStatus, defender)
            msgID      = xi.msg.basic.ADD_EFFECT_STATUS
            defender:addStatusEffect(addStatus, power, tick, duration)
            msgParam = addStatus
        end

    elseif addType == procType.HP_HEAL then -- Its not a drain and works vs undead. https://www.bg-wiki.com/bg/Dominion_Mace
        local hitPoints = damage -- Note: not actually damage, if you wanted damage see HP_DRAIN instead
        -- Unknown what modifies the HP, using power directly for now
        msgID = xi.msg.basic.ADD_EFFECT_HP_HEAL
        attacker:addHP(hitPoints)
        msgParam = hitPoints

    elseif addType == procType.MP_HEAL then -- Mjollnir does this, it is not Aspir.
        local magicPoints = damage
        -- Unknown what modifies this, using power directly for now
        msgID = xi.msg.basic.ADD_EFFECT_MP_HEAL
        attacker:addMP(magicPoints)
        msgParam = magicPoints

    elseif
        addType == procType.HP_DRAIN or
        (addType == procType.HPMPTP_DRAIN and drainRoll == 1)
    then
        damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage)

        if damage > defender:getHP() then
            damage = defender:getHP()
        end

        msgID    = xi.msg.basic.ADD_EFFECT_HP_DRAIN
        msgParam = damage
        attacker:addHP(damage)

    elseif
        addType == procType.MP_DRAIN or
        (addType == procType.HPMPTP_DRAIN and drainRoll == 2)
    then
        damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage)

        if damage > defender:getMP() then
            damage = defender:getMP()
        end

        msgID    = xi.msg.basic.ADD_EFFECT_MP_DRAIN
        msgParam = damage
        defender:addMP(-damage)
        attacker:addMP(damage)

    elseif
        addType == procType.TP_DRAIN or
        (addType == procType.HPMPTP_DRAIN and drainRoll == 3)
    then
        damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage)

        if damage > defender:getTP() then
            damage = defender:getTP()
        end

        msgID    = xi.msg.basic.ADD_EFFECT_TP_DRAIN
        msgParam = damage
        defender:addTP(-damage)
        attacker:addTP(damage)

    elseif addType == procType.DISPEL then
        local dispel = defender:dispelStatusEffect()
        -- Resistance check should be in dispelStatusEffect() itself
        if dispel == xi.effect.NONE then
            return 0, 0, 0
        else
            msgID = xi.msg.basic.ADD_EFFECT_DISPEL
            msgParam = dispel
        end

    elseif addType == procType.ABSORB_STATUS then
        -- Ripping off Aura Steal here
        local resist = applyResistanceAddEffect(attacker, defender, element, 0)
        if resist > 0.0625 then
            local stolen = attacker:stealStatusEffect(defender)
            msgID        = xi.msg.basic.STEAL_EFFECT
            msgParam     = stolen
        end

    elseif addType == procType.SELF_BUFF then
        if addStatus == xi.effect.BLINK then -- BLINK http://www.ffxiah.com/item/18830/gusterion
            -- Does not stack with or replace other shadows
            if
                attacker:hasStatusEffect(xi.effect.BLINK) or
                attacker:hasStatusEffect(xi.effect.UTSUSEMI)
            then
                return 0, 0, 0
            else
                attacker:addStatusEffect(xi.effect.BLINK, power, 0, duration)
                msgID    = xi.msg.basic.ADD_EFFECT_SELFBUFF
                msgParam = xi.effect.BLINK
            end
        elseif addStatus == xi.effect.HASTE then
            attacker:addStatusEffect(xi.effect.HASTE, power, 0, duration, 0, 0)
            -- Todo: verify power/duration/tier/overwrite etc
            msgID    = xi.msg.basic.ADD_EFFECT_SELFBUFF
            msgParam = xi.effect.HASTE
        else
            print('scripts/globals/additional_effects.lua : unhandled additional effect selfbuff! Effect ID: '..addStatus)
        end

    elseif addType == procType.DEATH then
        if
            defender:isNM() or
            defender:isUndead() or
            -- Todo: DeathRes has no place in the resistance functions so far..
            math.random(1, 100) > defender:getMod(xi.mod.DEATHRES) -- We are checking for a fail, not a success.
        then
            return 0, 0, 0 -- NMs immune or roll failed so return out
        else
            msgID = xi.msg.basic.ADD_EFFECT_STATUS
            msgParam = xi.effect.KO
            defender:setHP(0)
        end
    end

    --[[
    if msgID == nil then
        print('Additional effect has a nil msgID !!')
    elseif msgParam == nil then
        print('Additional effect has a nil msgParam !!')
    end
    print('subEffect: '..subEffect..' msgID: '..msgID..' msgParam: '..msgParam)
    ]]
    return subEffect, msgID, msgParam
end

xi.additionalEffect.spikes = function(attacker, defender, damage, spikeEffect, power, chance)
    --[[ Todo..
    local procType =
    {
        -- These are arbitrary, make up new ones as needed.
    }
    ]]
end
