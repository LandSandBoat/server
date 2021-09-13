------------------------------------------------------------------------------
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
------------------------------------------------------------------------------
require("scripts/globals/teleports") -- For warp weapon proc.
require("scripts/globals/status")
require("scripts/globals/magic") -- For resist functions
require("scripts/globals/utils") -- For clamping function
require("scripts/globals/msg")
--------------------------------------

xi = xi or {}
xi.additionalEffect = xi.additionalEffect or {}

xi.additionalEffect.isRanged = function(item)
    -- Archery/Marksmanship/Throwing
    return math.abs(item:getSkillType() - xi.skill.MARKSMANSHIP) < 2
end

xi.additionalEffect.calcRangeBonus = function(attacker, defender, element, damage)
    -- Copied from existing scripts.
    local bonus = 0
    if element == xi.magic.ele.LIGHT then
        bonus = attacker:getStat(xi.mod.MND) - defender:getStat(xi.mod.MND)
        if bonus > 40 then
            bonus = bonus + (bonus -40) /2;
            damage = damage + bonus
        end
    else
        bonus = attacker:getStat(xi.mod.INT) - defender:getStat(xi.mod.INT)
        if bonus > 20 then
            bonus = bonus + (bonus -20) /2;
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
        [xi.effect.DEFENSE_DOWN] = {tick = 0, strip = xi.effect.DEFENSE_BOOST},
        [xi.effect.EVASION_DOWN] = {tick = 0, strip = xi.effect.EVASION_BOOST},
        [xi.effect.ATTACK_DOWN]  = {tick = 0, strip = xi.effect.ATTACK_BOOST},
        [xi.effect.POISON]       = {tick = 3, strip = nil},
        [xi.effect.CHOKE]        = {tick = 3, strip = nil},
    }
    local effect = effectList[addStatus]
    defender:delStatusEffect(effect.strip)
    return effect.tick
end

xi.additionalEffect.calcDamage = function(attacker, element, defender, damage)
    local params = {}
    params.bonusmab = 0
    params.includemab = false
    damage = addBonusesAbility(attacker, element, defender, damage, params)
    damage = damage * applyResistanceAddEffect(attacker, defender, element, 0)
    damage = adjustForTarget(defender, damage, element)
    damage = finalMagicNonSpellAdjustments(attacker, defender, element, damage)

    --[[
    This should rightly be modified by resistance checks, and while those DO they are presently not perfect.
    If you want to force some randomness, un-comment the line below to artificially force 20% variance.
    ]]
    -- damage = damage * (math.random(90, 110)/100) --

    return damage
end

-- paralyze on hit, fire damage on hit, etc..
xi.additionalEffect.attack(attacker, defender, baseAttackDamage, item)
    local addType = item:getMod(xi.mod.ITEM_ADDEFFECT_TYPE)
    local subEffect = item:getMod(xi.mod.ITEM_SUBEFFECT)
    local damage = item:getMod(xi.mod.ITEM_ADDEFFECT_DMG)
    local chance = item:getMod(xi.mod.ITEM_ADDEFFECT_CHANCE)
    local element = item:getMod(xi.mod.ITEM_ADDEFFECT_ELEMENT)
    local addStatus = item:getMod(xi.mod.ITEM_ADDEFFECT_STATUS)
    local power = item:getMod(xi.mod.ITEM_ADDEFFECT_POWER)
    local duration = item:getMod(xi.mod.ITEM_ADDEFFECT_DURATION)
    local msgID = 0
    local msgParam = 0
    local procType =
    {
        -- These are arbitrary, make up new ones as needed.
        NORMAL = 1,
        HP_HEAL = 2,
        MP_HEAL = 3,
        HP_DRAIN = 4,
        MP_DRAIN = 5,
        TP_DRAIN = 6,
        HPMPTP_DRAIN = 7,
        DISPEL = 8,
        SELF_BUFF = 9,
        DEATH = 10,
    }

    -- If we're not going to proc, lets not execute all those checks!
    if chance < math.random(100) then
        return 0,0,0
    end

    --------------------------------------
    -- Modifications for proc's sourced from ranged attacks. See notes at top of script.
    if xi.addEffect.isRanged(item) then
        if element then
            damage = xi.addEffect.calcRangeBonus(attacker, defender, element, damage)
        end
        chance = xi.addEffect.levelCorrection(defender:getMainLvl(), attacker:getMainLvl(), chance)
    end
    --------------------------------------

    if addType == procType.NORMAL then
        if addStatus and addStatus > 0 then
            local tick = xi.addEffect.statusAttack(addStatus, defender)
            msgID = xi.msg.basic.ADD_EFFECT_STATUS
            defender:addStatusEffect(addStatus, power, tick, duration)
            msgParam = addStatus
        end

        if damage > 0 then
            -- local damage = damage * (math.random(90, 110)/100) -- Artificially forcing 20% variance.
            damage = xi.addEffect.calcDamage(attacker, element, defender, damage)
            msgID = xi.msg.basic.ADD_EFFECT_DMG
            if damage < 0 then
                msgID = xi.msg.basic.ADD_EFFECT_HEAL
            end
            msgParam = damage
        end

    elseif addType == procType.HP_HEAL then -- Its not a drain and works vs undead. https://www.bg-wiki.com/bg/Dominion_Mace
        local HP = damage -- Note: not actually damage, if you wanted damage see HP_DRAIN instead
        -- Unknown what modifies the HP, using power directly for now
        msgID = xi.msg.basic.ADD_EFFECT_HP_HEAL
        attacker:addHP(HP)
        msgParam = HP

    elseif addType == procType.MP_HEAL then -- Mjollnir does this, it is not Aspir.
        local MP = damage
        -- Unknown what modifies this, using power directly for now
        msgID = xi.msg.basic.ADD_EFFECT_MP_HEAL
        attacker:addMP(MP)
        msgParam = MP

    elseif addType == procType.HP_DRAIN or (addType == procType.HPMPTP_DRAIN and math.random(1,3) == 1) then
        damage = xi.addEffect.calcDamage(attacker, element, defender, damage)
        if damage > defender:getHP() then
            damage = defender:getHP()
        end

        msgID = xi.msg.basic.ADD_EFFECT_HP_DRAIN
        msgParam = damage
        defender:addHP(-damage)
        attacker:addHP(damage)

    elseif addType == procType.MP_DRAIN or (addType == procType.HPMPTP_DRAIN and math.random(1,3) == 2) then
        damage = xi.addEffect.calcDamage(attacker, element, defender, damage)
        if damage > defender:getMP() then
            damage = defender:getMP()
        end
        msgID = xi.msg.basic.ADD_EFFECT_MP_DRAIN
        msgParam = damage
        defender:addMP(-damage)
        attacker:addMP(damage)

    elseif addType == procType.TP_DRAIN or (addType == procType.HPMPTP_DRAIN and math.random(1,3) == 3) then
        damage = xi.addEffect.calcDamage(attacker, element, defender, damage)
        if damage > defender:getTP() then
            damage = defender:getTP()
        end
        msgID = xi.msg.basic.ADD_EFFECT_TP_DRAIN
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

    elseif addType == procType.SELF_BUFF then
        if addStatus == xi.effect.TELEPORT then -- WARP
            attacker:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.WARP, 0, 1)
            msgID = xi.msg.basic.ADD_EFFECT_WARP
            msgParam = 0
        elseif addStatus == xi.effect.BLINK then -- BLINK http://www.ffxiah.com/item/18830/gusterion
            -- Does not stack with or replace other shadows
            if attacker:hasStatusEffect(xi.effect.BLINK) or attacker:hasStatusEffect(xi.effect.UTSUSEMI) then
                return 0, 0, 0
            else
                attacker:addStatusEffect(xi.effect.BLINK, power, 0, duration)
                msgID = ADD_EFFECT_SELFBUFF
                msgParam = xi.effect.BLINK
            end
        elseif addStatus == xi.effect.HASTE then
            attacker:addStatusEffect(xi.effect.HASTE, power, 0, duration, 0, 0)
            -- Todo: verify power/duration/tier/overwrite etc
            msgID = ADD_EFFECT_SELFBUFF
            msgParam = xi.effect.HASTE
        else
            print("scripts/globals/additional_effects.lua : unhandled additional effect selfbuff! Effect ID: "..addStatus)
        end

    elseif addType == procType.DEATH then
        if
            defender:isNM() or
            target:isUndead() or
            -- Todo: DeathRes has no place in the resistance functions so far..
            target:getMod(xi.mod.DEATHRES) > math.random(100)
        then
            return 0, 0, 0 -- NMs immune, so return out
        else
            msgID = xi.msg.basic.ADD_EFFECT_STATUS
            msgParam = xi.effect.KO
            defender:setHP(0)
        end
    end

    --[[
    if msgID == nil then
        print("Additional effect has a nil msgID !!")
    elseif msgParam == nil then
        print("Additional effect has a nil msgParam !!")
    end
    print("subEffect: "..subEffect.." msgID: "..msgID.." msgParam: "..msgParam)
    ]]
    return subEffect, msgID, msgParam
end

xi.additionalEffect.spikes(attacker, defender, damage, spikeEffect, power, chance)
    --[[ Todo..
    local procType =
    {
        -- These are arbitrary, make up new ones as needed.
    }
    ]]
end
