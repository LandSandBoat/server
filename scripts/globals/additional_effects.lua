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
-- Ranged throwing items have weird cases that don't fully fit in the above,
-- and a handfull of weapons have seem to scale up the more magic accuracy you have
-- Yes accuracy, not attack. More research needed. Not adding them till we know how they work.
-- (And then these comments get cleaned up)
-----------------------------------
require('scripts/globals/teleports') -- For warp weapon proc.
require('scripts/globals/magic') -- For resist functions
require('scripts/globals/utils') -- For clamping function
-----------------------------------
xi = xi or {}
xi.additionalEffect = xi.additionalEffect or {}
xi.additionalEffect.procFunctions = xi.additionalEffect.procFunctions or {}

xi.additionalEffect.dStatBonus = function(attacker, defender, dStat, damage)
    local statTable =
    {
        -- [attacker stat] = {counter stat, softcap},
        [xi.mod.MND] = { cStat = xi.mod.MND, softcap = 40 },
        [xi.mod.INT] = { cStat = xi.mod.INT, softcap = 20 },
        -- Can use pretty much any modifier and the pairs don't have to math (in case of SE shenanigans..)
    }

    local tableRow = statTable[dStat]
    local sCap = tableRow.softcap
    local bonus = 0

    -- Check if this is base stat or other modifier
    if dStat >= xi.mod.STR and dStat <= xi.mod.CHR then
        bonus = attacker:getStat(dStat) - defender:getStat(tableRow.cStat)
    else
        -- See table note above
        bonus = attacker:getMod(dStat) - defender:getMod(tableRow.cStat)
    end

    if bonus then
        if sCap > 0 and bonus > sCap then
            bonus = bonus + (bonus - sCap) / 2
        end

        if bonus > 0 then
            damage = damage + bonus
        end
    end

    return damage
end

xi.additionalEffect.levelCorrectRates = function(dLV, aLV, chance, lvCorrect)
    -- Do not alter 100% proc rates
    if chance < 100 then
        if dLV > aLV then
            chance = utils.clamp(chance - lvCorrect * (dLV - aLV), 1, 99)
        end
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

-- Todo: swap from using element to damageType enum, so Excalibur etc. can happen.
xi.additionalEffect.calcDamage = function(attacker, element, defender, damage)
    local params = {}

    params.bonusmab   = 0
    params.includemab = false -- May possibly need to include mab on case by case basis, further tests needed
    damage            = addBonusesAbility(attacker, element, defender, damage, params)
    damage            = damage * applyResistanceAddEffect(attacker, defender, element, 0)
    damage            = adjustForTarget(defender, damage, element)
    -- Todo: make sure day/weather/affinity bonuses tie in right here
    damage            = finalMagicNonSpellAdjustments(attacker, defender, element, damage)

    --[[
    This should rightly be modified by resistance checks, and while those DO they are presently not perfect.
    If you want to force some extra randomness, un-comment the line below to artificially force 20% variance.
    ]]
    -- damage = damage * (math.random(90, 110) / 100)

    return damage
end

xi.additionalEffect.procType =
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

-- TODO: add resistance check for params.element
xi.additionalEffect.procFunctions[xi.additionalEffect.procType.DAMAGE] = function(attacker, defender, item, params)
    local subEffect = params.subEffect
    local msgID     = 0
    local msgParam  = 0

    local damage = xi.additionalEffect.calcDamage(attacker, params.element, defender, params.damage)
    msgID  = xi.msg.basic.ADD_EFFECT_DMG

    if damage < 0 then
        msgID = xi.msg.basic.ADD_EFFECT_HEAL
    end

    msgParam = damage

    return subEffect, msgID, msgParam
end

-- TODO: add resistance check for params.element
-- TODO: add 1/2 duration or full duration only
-- TODO: verify how macc works with this
xi.additionalEffect.procFunctions[xi.additionalEffect.procType.DEBUFF] =  function(attacker, defender, item, params)
    local subEffect = params.subEffect
    local msgID     = 0
    local msgParam  = 0

    if params.addStatus and params.addStatus > 0 then
        local tick = xi.additionalEffect.statusAttack(params.addStatus, defender)
        msgID      = xi.msg.basic.ADD_EFFECT_STATUS_2 -- TODO: does anything use ADD_EFFECT_STATUS? STatus bolts are observed on retail to use _2.

        defender:addStatusEffect(params.addStatus, params.power, tick, params.duration)
        msgParam = params.addStatus
    end

    return subEffect, msgID, msgParam
end

xi.additionalEffect.procFunctions[xi.additionalEffect.procType.HP_HEAL] =  function(attacker, defender, item, params)
    local subEffect = params.subEffect
    local msgID     = 0
    local msgParam  = 0
    -- Its not a drain and works vs undead. https://www.bg-wiki.com/bg/Dominion_Mace
    local hitPoints = params.damage -- Note: not actually damage, if you wanted damage see HP_DRAIN instead
    -- Unknown what modifies the HP, using power directly for now
    msgID = xi.msg.basic.ADD_EFFECT_HP_HEAL
    attacker:addHP(hitPoints)
    msgParam = hitPoints

    return subEffect, msgID, msgParam
end

xi.additionalEffect.procFunctions[xi.additionalEffect.procType.MP_HEAL] =  function(attacker, defender, item, params)
    local subEffect = params.subEffect
    local msgID     = 0
    local msgParam  = 0

    local magicPoints = params.damage
    -- Unknown what modifies this, using power directly for now
    msgID = xi.msg.basic.ADD_EFFECT_MP_HEAL
    attacker:addMP(magicPoints)
    msgParam = magicPoints

    return subEffect, msgID, msgParam
end

-- TODO: add resistance check for params.element
xi.additionalEffect.procFunctions[xi.additionalEffect.procType.HP_DRAIN] =  function(attacker, defender, item, params)
    local subEffect = params.subEffect
    local msgID     = 0
    local msgParam  = 0

    -- Hardcoded for now
    params.element = xi.element.DARK
    local damage = xi.additionalEffect.calcDamage(attacker, params.element, defender, params.damage)

    if damage > defender:getHP() then
        damage = defender:getHP()
    end

    msgID    = xi.msg.basic.ADD_EFFECT_HP_DRAIN
    msgParam = damage
    attacker:addHP(damage)

    return subEffect, msgID, msgParam
end

-- TODO: add resistance check for params.element
xi.additionalEffect.procFunctions[xi.additionalEffect.procType.MP_DRAIN] =  function(attacker, defender, item, params)
    local subEffect = params.subEffect
    local msgID     = 0
    local msgParam  = 0

    -- Hardcoded for now
    params.element = xi.element.DARK
    local damage = xi.additionalEffect.calcDamage(attacker, params.element, defender, params.damage)

    if damage > defender:getMP() then
        damage = defender:getMP()
    end

    msgID    = xi.msg.basic.ADD_EFFECT_MP_DRAIN
    msgParam = damage
    defender:addMP(-damage)
    attacker:addMP(damage)

    return subEffect, msgID, msgParam
end

-- TODO: add resistance check for params.element
xi.additionalEffect.procFunctions[xi.additionalEffect.procType.TP_DRAIN] =  function(attacker, defender, item, params)
    local subEffect = params.subEffect
    local msgID     = 0
    local msgParam  = 0

    -- Hardcoded for now
    params.element = xi.element.DARK

    local damage = xi.additionalEffect.calcDamage(attacker, params.element, defender, params.damage)

    if damage > defender:getTP() then
        damage = defender:getTP()
    end

    msgID    = xi.msg.basic.ADD_EFFECT_TP_DRAIN
    msgParam = damage
    defender:addTP(-damage)
    attacker:addTP(damage)

    return subEffect, msgID, msgParam
end

-- TODO: add resistance check for params.element
xi.additionalEffect.procFunctions[xi.additionalEffect.procType.DISPEL] =  function(attacker, defender, item, params)
    local subEffect = params.subEffect
    local msgID     = 0
    local msgParam  = 0

    local dispel = defender:dispelStatusEffect()

    if dispel == xi.effect.NONE then
        return 0, 0, 0
    else
        msgID = xi.msg.basic.ADD_EFFECT_DISPEL
        msgParam = dispel
    end

    return subEffect, msgID, msgParam
end

xi.additionalEffect.procFunctions[xi.additionalEffect.procType.ABSORB_STATUS] =  function(attacker, defender, item, params)
    local subEffect = params.subEffect
    local msgID     = 0
    local msgParam  = 0

    -- Ripping off Aura Steal here
    local resist = applyResistanceAddEffect(attacker, defender, params.element, 0)
    if resist > 0.0625 then
        local stolen = attacker:stealStatusEffect(defender)
        msgID        = xi.msg.basic.STEAL_EFFECT
        msgParam     = stolen
    end

    return subEffect, msgID, msgParam
end

xi.additionalEffect.procFunctions[xi.additionalEffect.procType.SELF_BUFF] =  function(attacker, defender, item, params)
    local subEffect = params.subEffect
    local msgID     = 0
    local msgParam  = 0

    if params.addStatus == xi.effect.BLINK then -- BLINK http://www.ffxiah.com/item/18830/gusterion
        -- Does not stack with or replace other shadows
        if
            attacker:hasStatusEffect(xi.effect.BLINK) or
            attacker:hasStatusEffect(xi.effect.COPY_IMAGE)
        then
            return 0, 0, 0
        else
            attacker:addStatusEffect(xi.effect.BLINK, params.power, 0, params.duration)
            msgID    = xi.msg.basic.ADD_EFFECT_SELFBUFF
            msgParam = xi.effect.BLINK
        end
    elseif params.addStatus == xi.effect.HASTE then
        attacker:addStatusEffect(xi.effect.HASTE, params.power, 0, params.duration, 0, 0)
        -- Todo: verify power/duration/tier/overwrite etc
        msgID    = xi.msg.basic.ADD_EFFECT_SELFBUFF
        msgParam = xi.effect.HASTE
    else
        print('scripts/globals/additional_effects.lua : unhandled additional effect selfbuff! Effect ID: ' .. params.addStatus)
    end

    return subEffect, msgID, msgParam
end

xi.additionalEffect.procFunctions[xi.additionalEffect.procType.DEATH] = function(attacker, defender, item, params)
    local subEffect = params.subEffect
    local msgID     = 0
    local msgParam  = 0

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

    return subEffect, msgID, msgParam
end

xi.additionalEffect.procFunctions[xi.additionalEffect.procType.HPMP_DRAIN] = function(attacker, defender, item, params)
    local drainRoll = math.random(1, 2) -- This is wrong and needs retail verification. Current theory is that it rolls one after another until one doesn't resist or they all resist.

    local drainFuncs =
    {
        [1] = xi.additionalEffect.procType.HP_DRAIN,
        [2] = xi.additionalEffect.procType.MP_DRAIN
    }

    return xi.additionalEffect.procFunctions[drainFuncs[drainRoll]](attacker, defender, item, params)
end

xi.additionalEffect.procFunctions[xi.additionalEffect.procType.HPMPTP_DRAIN] = function(attacker, defender, item, params)
    local drainRoll = math.random(1, 3) -- This is wrong and needs retail verification. Current theory is that it rolls one after another until one doesn't resist or they all resist.

    local drainFuncs =
    {
        [1] = xi.additionalEffect.procType.HP_DRAIN,
        [2] = xi.additionalEffect.procType.MP_DRAIN,
        [3] = xi.additionalEffect.procType.TP_DRAIN
    }

    return xi.additionalEffect.procFunctions[drainFuncs[drainRoll]](attacker, defender, item, params)
end

-- paralyze on hit, fire damage on hit, etc.
xi.additionalEffect.attack = function(attacker, defender, baseAttackDamage, item)
    local params     = {}
    params.lvCorrect = item:getMod(xi.mod.ITEM_ADDEFFECT_LVADJUST)
    params.dStat     = item:getMod(xi.mod.ITEM_ADDEFFECT_DSTAT)
    params.addType   = item:getMod(xi.mod.ITEM_ADDEFFECT_TYPE)
    params.subEffect = item:getMod(xi.mod.ITEM_SUBEFFECT)
    params.damage    = item:getMod(xi.mod.ITEM_ADDEFFECT_DMG)
    params.chance    = item:getMod(xi.mod.ITEM_ADDEFFECT_CHANCE)
    params.element   = item:getMod(xi.mod.ITEM_ADDEFFECT_ELEMENT)
    params.addStatus = item:getMod(xi.mod.ITEM_ADDEFFECT_STATUS)
    params.power     = item:getMod(xi.mod.ITEM_ADDEFFECT_POWER)
    params.duration  = item:getMod(xi.mod.ITEM_ADDEFFECT_DURATION)

    -- This is the  damage of the auto attack that generated this function call (swing did 5 damage, base attack damage is 5)
    params.baseAttackDamage = baseAttackDamage

    -- If player is level synced below the level of the item, do no proc
    if item:getReqLvl() > attacker:getMainLvl() then
        return 0, 0, 0
    end

    -- If we're not going to proc, lets not execute all those checks!
    if math.random(1, 100) > params.chance then
        return 0, 0, 0
    end

    -- Archery/marksmanship use this, most other items -usually- do not (See notes at top of script).
    if params.dStat > 0 then
        params.damage = xi.additionalEffect.dStatBonus(attacker, defender, params.dStat, params.damage)
    end

    if xi.additionalEffect.procFunctions[params.addType] then
        return xi.additionalEffect.procFunctions[params.addType](attacker, defender, item, params)
    else
        print('ERR: xi.additionalEffect.attack passed invalid/unimplemented addType of ' .. tostring(params.addType))
    end

    return 0, 0, 0
end

xi.additionalEffect.spikes = function(attacker, defender, damage, spikeEffect, power, chance)
    --[[ Todo..
    local procType =
    {
        -- These are arbitrary, make up new ones as needed.
    }
    ]]
end
