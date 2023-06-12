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
require("scripts/globals/events/harvest_festivals")
--------------------------------------
xi = xi or {}
xi.additionalEffect = xi.additionalEffect or {}

xi.additionalEffect.procType =
{
    -- These are arbitrary, make up new ones as needed.
    DAMAGE          = 1,
    DEBUFF          = 2,
    HP_HEAL         = 3,
    MP_HEAL         = 4,
    HP_DRAIN        = 5,
    MP_DRAIN        = 6,
    TP_DRAIN        = 7,
    HPMPTP_DRAIN    = 8,
    DISPEL          = 9,
    ABSORB_STATUS   = 10,
    SELF_BUFF       = 11,
    DEATH           = 12,
    BRIGAND         = 13,
    VS_FAMILY       = 14,
    AVATAR_SUMMONED = 15,
    NIGHTTIME       = 16,
    GOD_WIND        = 17,
    VS_ECOSYSTEM    = 18,
}

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

xi.additionalEffect.calcDamage = function(attacker, element, defender, damage, addType, item)
    local params = {}
    params.bonusmab   = 0
    params.includemab = false
    params.damageSpell = true

    if
        addType == xi.additionalEffect.procType.DAMAGE and
        element == xi.magic.ele.LIGHT and
        item:getSkillType() == xi.skill.MARKSMANSHIP
    then
        params.element = xi.magic.ele.LIGHT
        params.attribute = xi.mod.MND
        params.skillType = item:getSkillType()
        params.damageSpell = true
        params.includemab = true
    end

    damage = xi.magic.addBonusesAbility(attacker, element, defender, damage, params)
    damage = damage * xi.magic.applyResistanceEffect(attacker, defender, nil, params)
    damage = xi.magic.adjustForTarget(defender, damage, element)
    damage = xi.magic.finalMagicNonSpellAdjustments(attacker, defender, element, damage)

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
    local option    = item:getMod(xi.mod.ITEM_ADDEFFECT_OPTION)
    local msgID     = 0
    local msgParam  = 0

    local immunityTable =
            {
                { status = xi.effect.SLEEP_I,   immunity = xi.immunity.SLEEP    },
                { status = xi.effect.WEIGHT,    immunity = xi.immunity.GRAVITY  },
                { status = xi.effect.BIND,      immunity = xi.immunity.BIND     },
                { status = xi.effect.STUN,      immunity = xi.immunity.STUN     },
                { status = xi.effect.SILENCE,   immunity = xi.immunity.SILENCE  },
                { status = xi.effect.PARALYSIS, immunity = xi.immunity.PARALYZE },
                { status = xi.effect.BLINDNESS, immunity = xi.immunity.BLIND    },
                { status = xi.effect.SLOW,      immunity = xi.immunity.SLOW     },
                { status = xi.effect.POISON,    immunity = xi.immunity.POISON   },
                { status = xi.effect.ELEGY,     immunity = xi.immunity.ELEGY    },
                { status = xi.effect.REQUIEM,   immunity = xi.immunity.REQUIEM  },
                { status = xi.effect.TERROR,    immunity = xi.immunity.TERROR   },
            }

    if
        addStatus == xi.effect.DEFENSE_DOWN and
        item:getSkillType() == xi.skill.MARKSMANSHIP
    then
        local dLvl = defender:getMainLvl() - attacker:getMainLvl()
        if dLvl <= 0 then
            chance = 99
        elseif dLvl <= 5 then
            chance = 99 - (1.5 * dLvl)
        else
            chance = 75 - (3 * (dLvl - 5))
        end

        if defender:isNM() then
            chance = chance / 1.5
        end
    end

    -- If player is level synced below the level of the item, do no proc
    if item:getReqLvl() > attacker:getMainLvl() then
        return 0, 0, 0
    end

    -- If we're not going to proc, lets not execute all those checks!
    if math.random(1, 100) > chance then
        return 0, 0, 0
    end

    --------------------------------------
    -- Modifications for proc's sourced from ranged attacks. See notes at top of script.
    --------------------------------------
    if xi.additionalEffect.isRanged(item) then
        if element then
            damage = xi.additionalEffect.calcRangeBonus(attacker, defender, element, damage)
        end

        -- Do not adjust the chance of effects that are guaranteed (like god winds)
        if chance ~= 100 then
            chance = xi.additionalEffect.levelCorrection(defender:getMainLvl(), attacker:getMainLvl(), chance)
        end
    end

    --------------------------------------
    -- Additional Effect Damage
    --------------------------------------
    if addType == xi.additionalEffect.procType.DAMAGE then
        if
            element == xi.magic.ele.LIGHT and
            item:getSkillType() == xi.skill.MARKSMANSHIP
        then
            damage = math.floor(attacker:getStat(xi.mod.MND) / 2) -- MAB/MDB bonuses caled in xi.additionalEffect.calcDamage.
        end

        damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage, addType, item)
        msgID  = xi.msg.basic.ADD_EFFECT_DMG

        if damage < 0 then
            msgID = xi.msg.basic.ADD_EFFECT_HEAL
        end

        msgParam = damage
    --------------------------------------
    -- Inflicts negative effects vs target
    --------------------------------------
    elseif addType == xi.additionalEffect.procType.DEBUFF then
        if addStatus and addStatus > 0 then
            local tick   = xi.additionalEffect.statusAttack(addStatus, defender)
            local resist = xi.magic.applyResistanceAddEffect(attacker, defender, element, addStatus, 0, item:getSkillType())
            local immunity = 0

            for _, statusTable in pairs(immunityTable) do
                if statusTable.status == addStatus then
                    immunity = statusTable.immunity
                    break
                end
            end

            if
                resist >= 0.5 and
                duration * resist > 0 and
                not defender:hasImmunity(immunity)
            then
                defender:addStatusEffect(addStatus, power, tick, duration * resist)
                msgID    = xi.msg.basic.ADD_EFFECT_STATUS
                msgParam = addStatus
            else
                return 0, 0, 0
            end
        end
    --------------------------------------
    -- Recovers user's HP
    --------------------------------------
    elseif addType == xi.additionalEffect.procType.HP_HEAL then -- Its not a drain and works vs undead. https://www.bg-wiki.com/bg/Dominion_Mace
        local hitPoints = damage -- Note: not actually damage, if you wanted damage see HP_DRAIN instead
        -- Unknown what modifies the HP, using power directly for now
        msgID = xi.msg.basic.ADD_EFFECT_HP_HEAL
        attacker:addHP(hitPoints)
        msgParam = hitPoints

    --------------------------------------
    -- Recovers user's MP
    --------------------------------------
    elseif addType == xi.additionalEffect.procType.MP_HEAL then -- Mjollnir does this, it is not Aspir.
        local magicPoints = damage
        -- Unknown what modifies this, using power directly for now
        msgID = xi.msg.basic.ADD_EFFECT_MP_HEAL
        attacker:addMP(magicPoints)
        msgParam = magicPoints

    --------------------------------------
    -- Drains HP from target
    --------------------------------------
    elseif
        addType == xi.additionalEffect.procType.HP_DRAIN or
        (addType == xi.additionalEffect.procType.HPMPTP_DRAIN and math.random(1, 3) == 1)
    then
        damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage, addType, item)

        -- Upyri: ID 4105
        if defender:isUndead() or defender:getPool() == 4105 then
            return 0
        end

        if damage > defender:getHP() then
            damage = defender:getHP()
        end

        msgID    = xi.msg.basic.ADD_EFFECT_HP_DRAIN
        msgParam = damage
        defender:addHP(-damage)
        attacker:addHP(damage)

    --------------------------------------
    -- Drains MP from target
    --------------------------------------
    elseif
        addType == xi.additionalEffect.procType.MP_DRAIN or
        (addType == xi.additionalEffect.procType.HPMPTP_DRAIN and math.random(1, 3) == 2)
    then
        damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage, addType, item)

        if damage > defender:getMP() then
            damage = defender:getMP()
        elseif defender:getMP() == 0 then
            return 0, 0, 0 -- Conditions not hit
        end

        msgID    = xi.msg.basic.ADD_EFFECT_MP_DRAIN
        msgParam = damage
        defender:addMP(-damage)
        attacker:addMP(damage)

    --------------------------------------
    -- Drains TP from target
    --------------------------------------
    elseif
        addType == xi.additionalEffect.procType.TP_DRAIN or
        (addType == xi.additionalEffect.procType.HPMPTP_DRAIN and math.random(1, 3) == 3)
    then
        damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage, addType, item)

        if damage > defender:getTP() then
            damage = defender:getTP()
        elseif defender:getTP() == 0 then
            return 0, 0, 0 -- Conditions not hit
        end

        msgID    = xi.msg.basic.ADD_EFFECT_TP_DRAIN
        msgParam = damage
        defender:addTP(-damage)
        attacker:addTP(damage)

    --------------------------------------
    -- Dispels dispelable effects from target
    --------------------------------------
    elseif addType == xi.additionalEffect.procType.DISPEL then
        local dispel = defender:dispelStatusEffect()
        -- Resistance check should be in dispelStatusEffect() itself
        if dispel == xi.effect.NONE then
            return 0, 0, 0
        elseif not defender:hasImmunity(xi.immunity.DISPEL) then
            msgID = xi.msg.basic.ADD_EFFECT_DISPEL
            msgParam = dispel
        else
            return 0, 0, 0
        end

    elseif addType == xi.additionalEffect.procType.ABSORB_STATUS then
        -- Ripping off Aura Steal here
        local resist = xi.magic.applyResistanceAddEffect(attacker, defender, element, nil, 0)
        if resist > 0.0625 then
            local stolen = attacker:stealStatusEffect(defender)
            msgID        = xi.msg.basic.STEAL_EFFECT
            msgParam     = stolen
        else
            return 0, 0, 0 -- Conditions not hit
        end

    --------------------------------------
    -- Buffs that affect the player
    --------------------------------------
    elseif addType == xi.additionalEffect.procType.SELF_BUFF then
        if addStatus == xi.effect.TELEPORT then -- WARP
            attacker:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.WARP, 0, 1)
            msgID    = xi.msg.basic.ADD_EFFECT_WARP
            msgParam = 0
        elseif addStatus == xi.effect.BLINK then -- BLINK http://www.ffxiah.com/item/18830/gusterion
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
            print("scripts/globals/additional_effects.lua : unhandled additional effect selfbuff! Effect ID: "..addStatus)
        end

    --------------------------------------
    -- Inflicts death
    --------------------------------------
    elseif addType == xi.additionalEffect.procType.DEATH then
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

    --------------------------------------
    -- Special case for Bucc. knife
    --------------------------------------
    elseif addType == xi.additionalEffect.procType.BRIGAND then
        if
            defender:getPool() == 531 and
            attacker:getEquipID(xi.slot.MAIN) == xi.items.BUCCANEERS_KNIFE
        then
            defender:setMod(xi.mod.DMG, 0)
            defender:setLocalVar("killable", 1)
            defender:setUnkillable(false)
            damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage, addType, item)
            msgID = xi.msg.basic.ADD_EFFECT_DMG

            if damage < 0 then
                msgID = xi.msg.basic.ADD_EFFECT_HEAL
            end

            msgParam = damage
        else
            return 0, 0, 0 -- Conditions not hit
        end

    --------------------------------------
    -- Additional effects vs various super families
    -- Note: This checks a mobs super family to cover all types of
    --       mobs within a family.
    --   Ex: Beast, Lizard, Orc, etc.
    --------------------------------------
    elseif addType == xi.additionalEffect.procType.VS_FAMILY then
        if defender:getSuperFamily() == option then
            -- If Drain effect:
            if subEffect == xi.subEffect.HP_DRAIN then
                damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage, addType, item)

                if damage > defender:getHP() then
                    damage = defender:getHP()
                end

                msgID    = xi.msg.basic.ADD_EFFECT_HP_DRAIN
                msgParam = damage
                defender:addHP(-damage)
                attacker:addHP(damage)

            -- If debuff effect
            elseif addStatus and addStatus > 0 then
                local tick   = xi.additionalEffect.statusAttack(addStatus, defender)
                local resist = xi.magic.applyResistanceAddEffect(attacker, defender, element, addStatus, 0)
                local immunity = 0

                for _, statusTable in pairs(immunityTable) do
                    if statusTable.status == addStatus then
                        immunity = statusTable.immunity
                        break
                    end
                end

                if
                    resist >= 0.5 and
                    duration * resist > 0 and
                    not defender:hasImmunity(immunity)
                then
                    defender:addStatusEffect(addStatus, power, tick, duration * resist)
                    msgID    = xi.msg.basic.ADD_EFFECT_STATUS
                    msgParam = addStatus
                end

            -- Else damaging effect
            else
                damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage, addType, item)
                msgID  = xi.msg.basic.ADD_EFFECT_DMG

                if damage < 0 then
                    msgID = xi.msg.basic.ADD_EFFECT_HEAL
                end

                msgParam = damage
            end
        else
            return 0, 0, 0 -- Conditions not hit
        end

    --------------------------------------
    -- Additional effects trigger when specific avatar is summoned in party.
    -- Option is used to determine the specific avatar required to trigger.
    -- This ID reads from pets.lua (xi.pet.id)
    --------------------------------------
    elseif addType == xi.additionalEffect.procType.AVATAR_SUMMONED then
        local flag = false

        for _, member in pairs(attacker:getParty()) do
            if
                member:getPet() ~= nil and
                member:getPetID() == option
            then
                flag = true
            end
        end

        if flag then
            damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage, addType, item)
            msgID  = xi.msg.basic.ADD_EFFECT_DMG

            if damage < 0 then
                msgID = xi.msg.basic.ADD_EFFECT_HEAL
            end

            msgParam = damage
        else
            return 0, 0, 0 -- Conditions not hit
        end

    --------------------------------------
    -- Triggers at night
    --------------------------------------
    elseif addType == xi.additionalEffect.procType.NIGHTTIME then
        local time = VanadielHour()

        if time >= 20 and time <= 4 then
            damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage, addType, item)
            msgID  = xi.msg.basic.ADD_EFFECT_DMG

            if damage < 0 then
                msgID = xi.msg.basic.ADD_EFFECT_HEAL
            end

            msgParam = damage
        else
            return 0, 0, 0 -- Conditions not hit
        end

    --------------------------------------
    -- Throwables towards Gods in sky to
    -- dispel their en-effect
    --------------------------------------
    elseif addType == xi.additionalEffect.procType.GOD_WIND then
        if defender:getFamily() == option then
            defender:setMobMod(xi.mobMod.ADD_EFFECT, 0)
        else
            return 0, 0, 0 -- Conditions not hit
        end

    --------------------------------------
    -- Additional effects vs various family ecosystems
    -- Note: This checks a mob's ecosystem to cover all types of
    --       mobs within an ecosystem.
    --   Ex: Plantoid, Beast, Aquatic
    --------------------------------------
    elseif addType == xi.additionalEffect.procType.VS_ECOSYSTEM then
        if defender:getSystem() == option then
            -- If Drain effect:
            if subEffect == xi.subEffect.HP_DRAIN then
                damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage, addType, item)

                if damage > defender:getHP() then
                    damage = defender:getHP()
                end

                msgID    = xi.msg.basic.ADD_EFFECT_HP_DRAIN
                msgParam = damage
                defender:addHP(-damage)
                attacker:addHP(damage)

            -- If Debuff effect:
            elseif addStatus and addStatus > 0 then
                local tick   = xi.additionalEffect.statusAttack(addStatus, defender)
                local resist = xi.magic.applyResistanceAddEffect(attacker, defender, element, addStatus, 0)
                local immunity = 0

                for _, statusTable in pairs(immunityTable) do
                    if statusTable.status == addStatus then
                        immunity = statusTable.immunity
                        break
                    end
                end

                if
                    resist >= 0.5 and
                    duration * resist > 0 and
                    not defender:hasImmunity(immunity)
                then
                    defender:addStatusEffect(addStatus, power, tick, duration * resist)
                    msgID    = xi.msg.basic.ADD_EFFECT_STATUS
                    msgParam = addStatus
                end

            -- Else damaging effect
            else
                damage = xi.additionalEffect.calcDamage(attacker, element, defender, damage, addType, item)
                msgID  = xi.msg.basic.ADD_EFFECT_DMG

                if damage < 0 then
                    msgID = xi.msg.basic.ADD_EFFECT_HEAL
                end

                msgParam = damage
            end
        else
            return 0, 0, 0 -- Conditions not hit
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

xi.additionalEffect.spikes = function(attacker, defender, damage, spikeEffect, power, chance)
    --[[ Todo..
    local xi.additionalEffect.procType =
    {
        -- These are arbitrary, make up new ones as needed.
    }
    ]]
end
