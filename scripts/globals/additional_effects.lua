------------------------------------------------------------------------------
-- This global is intended to handle additional effects from item sources of:
-- melee attacks, ranged attacks, auto-spikes
-- Notes:
-- Ranged versions get bonus from int/mnd, melee does NOT.
-- No matter how much INT you stack that fire sword doesn't hit any harder.
-- No matter how much MND you stack that holy mace doesn't hit any harder.
-- But Ice Arrows and Bloody Bolts will gain damage from INT and Holy bolts will gain damage from MND.
-- Melee weapon proc also do not appear to adjust for level, only resistance.
-- In testing my fire sword had the same dmg ranges no matter my level vs same mob.
-- Weakness/resistance to element would swing damage range a lot
-- For status effects is it possible to land on highly resistant mobs because of flooring.
------------------------------------------------------------------------------
require("scripts/globals/teleports") -- For warp weapon proc.
require("scripts/globals/status")
require("scripts/globals/magic") -- For resist functions
require("scripts/globals/utils") -- For clamping function
require("scripts/globals/msg")
--------------------------------------

local procType =
{
    NORMAL = 1,
    HEAL = 2,
    HP_DRAIN = 3,
    MP_DRAIN = 4,
    TP_DRAIN = 5,
    DISPEL = 6,
    SELF_BUFF = 7,
    DEATH = 8,
    HPMPTP_DRAIN = 9
}

function additionalEffectAttack(attacker, defender, baseAttackDamage, item)
    local params = {}
    params.addType = item:getMod(dsp.mod.ITEM_ADDEFFECT_TYPE)
    params.subEffect = item:getMod(dsp.mod.ITEM_SUBEFFECT)
    params.damage = item:getMod(dsp.mod.ITEM_ADDEFFECT_DMG)
    params.chance = item:getMod(dsp.mod.ITEM_ADDEFFECT_CHANCE)
    params.element = item:getMod(dsp.mod.ITEM_ADDEFFECT_ELEMENT)
    params.addStatus = item:getMod(dsp.mod.ITEM_ADDEFFECT_STATUS)
    params.power = item:getMod(dsp.mod.ITEM_ADDEFFECT_POWER)
    params.duration = item:getMod(dsp.mod.ITEM_ADDEFFECT_DURATION)
    params.tick = 0
    local msgID = 0
    local msgValue = 0

    --------------------------------------
    -- Modifications for proc's sourced from ranged attacks. See notes at top of script.
    if
        params.damage > 0 and
        (item:getSkillType() == dsp.skill.ARCHERY or
        item:getSkillType() == dsp.skill.MARKSMANSHIP or
        item:getSkillType() == dsp.skill.THROWING)
    then
        local bonus = 0
        if params.element ~= nil and params.element == dsp.magic.ele.LIGHT then
            bonus = attacker:getStat(dsp.mod.INT) - defender:getStat(dsp.mod.INT)
            if bonus > 20 then
                -- Copied from existing scripts.
                bonus = bonus + (bonus -20) /2;
                params.damage = params.damage + bonus
            end
        elseif params.element ~= nil then
            bonus = attacker:getStat(dsp.mod.MND) - defender:getStat(dsp.mod.MND)
            if bonus > 40 then
                -- Copied from existing scripts.
                bonus = bonus + (bonus -40) /2;
                params.damage = params.damage + bonus
            end
        end

        -- Level correction of proc chance (copied from existing bolt/arrow scripts, looks wrong..)
        if defender:getMainLvl() > attacker:getMainLvl() then
            params.chance = params.chance - 5 * (defender:getMainLvl() - attacker:getMainLvl())
            params.chance = utils.clamp(params.chance, 5, 95)
        end
    end
    --------------------------------------

    if params.addType == procType.NORMAL then
        if params.damage > 0 then
            if params.chance <= math.random(100) then
                msgValue = nil
            else
                params.damage = params.damage*(math.random(90, 110)/100) -- Artificially forcing 20% variance.

                local params = {}
                params.bonusmab = 0
                params.includemab = false
                params.damage = addBonusesAbility(attacker, element, defender, dmg, params)
                params.damage = params.damage*applyResistanceAddEffect(attacker, defender, params.element, 0)
                params.damage = adjustForTarget(defender, damage, params.element)
                params.damage = finalMagicNonSpellAdjustments(attacker, defender, params.element, damage)

                if params.subEffect == dsp.subEffect.HP_DRAIN then
                    msgID = dsp.msg.basic.ADD_EFFECT_HP_DRAIN
                    if params.damage < 0 then
                        params.damage = 0
                    end
                else
                    msgID = dsp.msg.basic.ADD_EFFECT_DMG
                    if params.damage < 0 then
                        msgID = dsp.msg.basic.ADD_EFFECT_HEAL
                    end
                end
                msgValue = params.damage
            end
        end

        if addStatus ~= nil and addStatus ~= dsp.effect.NONE then
            msgID = dsp.msg.basic.ADD_EFFECT_STATUS

            if params.chance <= math.random(100) or applyResistanceAddEffect(attacker, defender, element, 0) <= 0.5 then
                msgValue = nil
            else
                if addStatus == dsp.effect.DEFENSE_DOWN then
                    defender:delStatusEffect(dsp.effect.DEFENSE_BOOST)
                elseif addStatus == dsp.effect.EVASION_DOWN then
                    defender:delStatusEffect(dsp.effect.EVASION_BOOST)
                elseif addStatus == dsp.effect.ATTACK_DOWN then
                    defender:delStatusEffect(dsp.effect.ATTACK_BOOST)
                end

                if addStatus == dsp.effect.POISON or addStatus == dsp.effect.CHOKE then
                    tick = 3
                end

                defender:addStatusEffect(addStatus, params.power, params.tick, params.duration)
                msgValue = addStatus
            end
        end
    end

    if params.addType == procType.HEAL then -- Its not a drain and works vs undead. https://www.bg-wiki.com/bg/Dominion_Mace
        if params.chance <= math.random(100) then
            msgValue = nil
        else
            local HP = 10 -- need actual calculation here!

            msgID = dsp.msg.basic.ADD_EFFECT_HP_HEAL
            attacker:addHP(HP)
            -- We have to fake this or it will say the defender was HEALed rather than the attacker.
            attacker:messageBasic(dsp.msg.basic.ADD_EFFECT_HP_HEAL)
            -- We're faking it, so return zeros!
            msgID = 0
            msgValue = 0
        end
    end

    if params.addType == procType.HEAL then -- Mjollnir does this
        if params.chance <= math.random(100) then
            msgValue = nil
        else
            local MP = 10 -- need actual calculation here!
            attacker:addHP(MP)
            -- We have to fake this or it will say the defender was HEALed rather than the attacker.
            attacker:messageBasic(dsp.msg.basic.ADD_EFFECT_MP_HEAL)
            -- We're faking it, so return zeros!
            msgID = 0
            msgValue = 0
        end
    end

    if params.addType == procType.HP_DRAIN or (addType == procType.HPMPTP_DRAIN and math.random(1,3) == 1) then -- procType.HP_DRAIN
        if params.chance <= math.random(100) then
            msgValue = nil
        else
            params.damage = params.damage*(math.random(90, 110)/100) -- Artificially forcing 20% variance.
            params.damage = params.damage*applyResistanceAddEffect(attacker, defender, element, 0)
            if damage > defender:getHP() then
                params.damage = defender:getHP()
            end

            msgID = dsp.msg.basic.ADD_EFFECT_HP_DRAIN
            msgValue = params.damage
            defender:addHP(-damage)
            attacker:addHP(damage)
        end
    end

    if params.addType == procType.MP_DRAIN or (addType == procType.HPMPTP_DRAIN and math.random(1,3) == 2) then
        if params.chance <= math.random(100) then
            msgValue = nil
        else
            params.damage = params.damage*(math.random(90, 110)/100) -- Artificially forcing 20% variance.
            params.damage = params.damage*applyResistanceAddEffect(attacker, defender, element, 0)
            if damage > defender:getMP() then
                params.damage = defender:getMP()
            end

            msgID = dsp.msg.basic.ADD_EFFECT_MP_DRAIN
            msgValue = params.damage
            defender:addMP(-damage)
            attacker:addMP(damage)
        end
    end

    if params.addType == procType.TP_DRAIN or (addType == procType.HPMPTP_DRAIN and math.random(1,3) == 3) then
        if params.chance <= math.random(100) then
            msgValue = nil
        else
            params.damage = params.damage*(math.random(90, 110)/100) -- Artificially forcing 20% variance.
            params.damage = params.damage*applyResistanceAddEffect(attacker, defender, element, 0)
            if damage > defender:getTP() then
                params.damage = defender:getTP()
            end

            msgID = dsp.msg.basic.ADD_EFFECT_TP_DRAIN
            msgValue = params.damage
            defender:addTP(-damage)
            attacker:addTP(damage)
        end
    end

    if params.addType == procType.DISPEL then
        if params.chance <= math.random(100) or applyResistanceAddEffect(attacker, defender, element, 0) <= 0.5 then
            msgValue = nil
        else
            local dispel = target:dispelStatusEffect()
            if dispel == dsp.effect.NONE then
                msgValue = nil
            else
                msgID = dsp.msg.basic.ADD_EFFECT_DISPEL
                msgValue = dispel
            end
        end
    end

    if params.addType == procType.SELF_BUFF then
        if params.chance <= math.random(100) then
            msgValue = nil
        else
            if addStatus == dsp.effect.TELEPORT then -- WARP
                attacker:addStatusEffectEx(dsp.effect.TELEPORT, 0, dsp.teleport.id.WARP, 0, 1)
                msgID = dsp.msg.basic.ADD_EFFECT_WARP
                msgValue = 0
            elseif addStatus == dsp.effect.BLINK then -- BLINK http://www.ffxiah.com/item/18830/gusterion
                -- Does not stack with or replace other shadows
                if params.chance <= math.random(100) or attacker:hasStatusEffect(dsp.effect.BLINK) or attacker:hasStatusEffect(dsp.effect.UTSUSEMI) then
                    msgValue = nil
                else
                    attacker:addStatusEffect(dsp.effect.BLINK, params.power, 0, params.duration)
                    -- We're faking it, so return zeros!
                    msgID = 0
                    msgValue = 0
                end
            else
                -- Only known one to go here so far is HASTE (not haste samba) http://www.ffxiah.com/search/item?q=blurred
                attacker:addStatusEffect(dsp.effect.HASTE, params.power, 0, params.duration, 0, 0) -- Todo: verify power/duration/tier
                -- We're faking it, so return zeros!
                msgID = 0
                msgValue = 0
            end
        end
    end

    if params.addType == procType.DEATH then
        if params.chance <= math.random(100) or defender:isNM() then
            msgValue = nil
        else
            msgID = dsp.msg.basic.ADD_EFFECT_STATUS
            msgValue = dsp.effect.KO
            defender:setHP(0)
        end
    end

    if msgValue == nil then
        return 0,0,0
    end

    return params.subEffect, msgID, msgValue
end

function additionalEffectSpikes(attacker, defender, damage, spikeEffect, power, chance)
    -- Todo..
end
