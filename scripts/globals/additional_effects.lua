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
    -- These are arbitrary, make up new ones as needed.
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
    local ae = {}
    ae.addType = item:getMod(dsp.mod.ITEM_ADDEFFECT_TYPE)
    ae.subEffect = item:getMod(dsp.mod.ITEM_SUBEFFECT)
    ae.damage = item:getMod(dsp.mod.ITEM_ADDEFFECT_DMG)
    ae.chance = 1000 --item:getMod(dsp.mod.ITEM_ADDEFFECT_CHANCE)
    ae.element = item:getMod(dsp.mod.ITEM_ADDEFFECT_ELEMENT)
    ae.addStatus = item:getMod(dsp.mod.ITEM_ADDEFFECT_STATUS)
    ae.power = item:getMod(dsp.mod.ITEM_ADDEFFECT_POWER)
    ae.duration = item:getMod(dsp.mod.ITEM_ADDEFFECT_DURATION)
    ae.tick = 0
    local msgID = 0
    local msgValue = 0
    local dmg = ae.damage * (math.random(90, 110)/100) -- Artificially forcing 20% variance.

    --------------------------------------
    -- Modifications for proc's sourced from ranged attacks. See notes at top of script.
    if
        ae.damage > 0 and
        (item:getSkillType() == dsp.skill.ARCHERY or
        item:getSkillType() == dsp.skill.MARKSMANSHIP or
        item:getSkillType() == dsp.skill.THROWING)
    then
        local bonus = 0
        if ae.element ~= nil and ae.element == dsp.magic.ele.LIGHT then
            bonus = attacker:getStat(dsp.mod.INT) - defender:getStat(dsp.mod.INT)
            if bonus > 20 then
                -- Copied from existing scripts.
                bonus = bonus + (bonus -20) /2;
                ae.damage = ae.damage + bonus
            end
        elseif ae.element ~= nil then
            bonus = attacker:getStat(dsp.mod.MND) - defender:getStat(dsp.mod.MND)
            if bonus > 40 then
                -- Copied from existing scripts.
                bonus = bonus + (bonus -40) /2;
                ae.damage = ae.damage + bonus
            end
        end

        -- Level correction of proc chance (copied from existing bolt/arrow scripts, looks wrong..)
        if defender:getMainLvl() > attacker:getMainLvl() then
            ae.chance = ae.chance - 5 * (defender:getMainLvl() - attacker:getMainLvl())
            ae.chance = utils.clamp(ae.chance, 5, 95)
        end
    end
    --------------------------------------

    if ae.addType == procType.NORMAL then
        if ae.addStatus ~= nil and ae.addStatus > 0 then
            msgID = dsp.msg.basic.ADD_EFFECT_STATUS

            if ae.chance <= math.random(100) or applyResistanceAddEffect(attacker, defender, ae.element, 0) <= 0.5 then
                msgValue = nil
            else
                if ae.addStatus == dsp.effect.DEFENSE_DOWN then
                    defender:delStatusEffect(dsp.effect.DEFENSE_BOOST)
                elseif ae.addStatus == dsp.effect.EVASION_DOWN then
                    defender:delStatusEffect(dsp.effect.EVASION_BOOST)
                elseif ae.addStatus == dsp.effect.ATTACK_DOWN then
                    defender:delStatusEffect(dsp.effect.ATTACK_BOOST)
                end

                if ae.addStatus == dsp.effect.POISON or ae.addStatus == dsp.effect.CHOKE then
                    tick = 3
                end

                defender:addStatusEffect(ae.addStatus, ae.power, ae.tick, ae.duration)
                msgValue = ae.addStatus
            end
        end

        if ae.damage > 0 then
            if ae.chance <= math.random(100) then
                msgValue = nil
            else
                local params = {}
                params.bonusmab = 0
                params.includemab = false
                dmg = addBonusesAbility(attacker, ae.element, defender, dmg, params)
                dmg = dmg * applyResistanceAddEffect(attacker, defender, ae.element, 0)
                dmg = adjustForTarget(defender, dmg, ae.element)
                dmg = finalMagicNonSpellAdjustments(attacker, defender, ae.element, dmg)

                if ae.subEffect == dsp.subEffect.HP_DRAIN then
                    msgID = dsp.msg.basic.ADD_EFFECT_HP_DRAIN
                    if dmg < 0 then
                        dmg = 0
                    end
                else
                    msgID = dsp.msg.basic.ADD_EFFECT_DMG
                    if dmg < 0 then
                        msgID = dsp.msg.basic.ADD_EFFECT_HEAL
                    end
                end
                msgValue = dmg
            end
        end
    end

    if ae.addType == procType.HEAL then -- Its not a drain and works vs undead. https://www.bg-wiki.com/bg/Dominion_Mace
        if ae.chance <= math.random(100) then
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

    if ae.addType == procType.HEAL then -- Mjollnir does this
        if ae.chance <= math.random(100) then
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

    if ae.addType == procType.HP_DRAIN or (addType == procType.HPMPTP_DRAIN and math.random(1,3) == 1) then -- procType.HP_DRAIN
        if ae.chance <= math.random(100) then
            msgValue = nil
        else
            dmg = dmg * applyResistanceAddEffect(attacker, defender, ae.element, 0)
            if dmg > defender:getHP() then
                dmg = defender:getHP()
            end

            msgID = dsp.msg.basic.ADD_EFFECT_HP_DRAIN
            msgValue = dmg
            defender:addHP(-dmg)
            attacker:addHP(dmg)
        end
    end

    if ae.addType == procType.MP_DRAIN or (addType == procType.HPMPTP_DRAIN and math.random(1,3) == 2) then
        if ae.chance <= math.random(100) then
            msgValue = nil
        else
            dmg = dmg * (math.random(90, 110)/100) -- Artificially forcing 20% variance.
            dmg = dmg * applyResistanceAddEffect(attacker, defender, ae.element, 0)
            if dmg > defender:getMP() then
                dmg = defender:getMP()
            end

            msgID = dsp.msg.basic.ADD_EFFECT_MP_DRAIN
            msgValue = dmg
            defender:addMP(-dmg)
            attacker:addMP(dmg)
        end
    end

    if ae.addType == procType.TP_DRAIN or (addType == procType.HPMPTP_DRAIN and math.random(1,3) == 3) then
        if ae.chance <= math.random(100) then
            msgValue = nil
        else
            dmg = dmg * (math.random(90, 110)/100) -- Artificially forcing 20% variance.
            dmg = dmg * applyResistanceAddEffect(attacker, defender, ae.element, 0)
            if dmg > defender:getTP() then
                dmg = defender:getTP()
            end

            msgID = dsp.msg.basic.ADD_EFFECT_TP_DRAIN
            msgValue = dmg
            defender:addTP(-dmg)
            attacker:addTP(dmg)
        end
    end

    if ae.addType == procType.DISPEL then
        if ae.chance <= math.random(100) or applyResistanceAddEffect(attacker, defender, ae.element, 0) <= 0.5 then
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

    if ae.addType == procType.SELF_BUFF then
        if ae.chance <= math.random(100) then
            msgValue = nil
        else
            if ae.addStatus == dsp.effect.TELEPORT then -- WARP
                attacker:addStatusEffectEx(dsp.effect.TELEPORT, 0, dsp.teleport.id.WARP, 0, 1)
                msgID = dsp.msg.basic.ADD_EFFECT_WARP
                msgValue = 0
            elseif ae.addStatus == dsp.effect.BLINK then -- BLINK http://www.ffxiah.com/item/18830/gusterion
                -- Does not stack with or replace other shadows
                if ae.chance <= math.random(100) or attacker:hasStatusEffect(dsp.effect.BLINK) or attacker:hasStatusEffect(dsp.effect.UTSUSEMI) then
                    msgValue = nil
                else
                    attacker:addStatusEffect(dsp.effect.BLINK, ae.power, 0, ae.duration)
                    -- We're faking it, so return zeros!
                    msgID = 0
                    msgValue = 0
                end
            else
                -- Only known one to go here so far is HASTE (not haste samba) http://www.ffxiah.com/search/item?q=blurred
                attacker:addStatusEffect(dsp.effect.HASTE, ae.power, 0, ae.duration, 0, 0) -- Todo: verify power/duration/tier
                -- We're faking it, so return zeros!
                msgID = 0
                msgValue = 0
            end
        end
    end

    if ae.addType == procType.DEATH then
        if ae.chance <= math.random(100) or defender:isNM() then
            msgValue = nil
        else
            msgID = dsp.msg.basic.ADD_EFFECT_STATUS
            msgValue = dsp.effect.KO
            defender:setHP(0)
        end
    end

    --[[ Why did I do this??
    if msgValue == nil then
        return 0,0,0
    end
    ]]

    return ae.subEffect, msgID, msgValue
end

function additionalEffectSpikes(attacker, defender, damage, spikeEffect, power, chance)
    -- Todo..
end
