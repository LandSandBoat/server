-----------------------------------
-- Thief Job Utilities
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.job_utils = xi.job_utils or {}
xi.job_utils.thief = xi.job_utils.thief or {}

-----------------------------------
-- Variable Definitions
-----------------------------------

local despoilDebuffs =
{
    xi.effect.EVASION_DOWN,
    xi.effect.DEFENSE_DOWN,
    xi.effect.ACCURACY_DOWN,
    xi.effect.ATTACK_DOWN,
    xi.effect.MAGIC_ATK_DOWN,
    xi.effect.MAGIC_DEF_DOWN,
    xi.effect.SLOW
}

local stealableSPEffects =
{
    xi.effect.MIGHTY_STRIKES,   xi.effect.HUNDRED_FISTS, xi.effect.MANAFONT,     xi.effect.CHAINSPELL,
    xi.effect.PERFECT_DODGE,    xi.effect.INVINCIBLE,    xi.effect.BLOOD_WEAPON, xi.effect.SOUL_VOICE,
    xi.effect.MEIKYO_SHISUI,    xi.effect.AZURE_LORE,    xi.effect.TRANCE,       xi.effect.BOLSTER,
    xi.effect.ELEMENTAL_SFORZO
}

-----------------------------------
-- Local Functions
-----------------------------------
local function processDebuff(player, target, ability, debuff)
    local power = 10

    if debuff == xi.effect.ATTACK_DOWN then
        ability:setMsg(xi.msg.basic.DESPOIL_ATT_DOWN)
        power = 20
    elseif debuff == xi.effect.DEFENSE_DOWN then
        ability:setMsg(xi.msg.basic.DESPOIL_DEF_DOWN)
        power = 30
    elseif debuff == xi.effect.MAGIC_ATK_DOWN then
        ability:setMsg(xi.msg.basic.DESPOIL_MATT_DOWN)
    elseif debuff == xi.effect.MAGIC_DEF_DOWN then
        ability:setMsg(xi.msg.basic.DESPOIL_MDEF_DOWN)
        power = 20
    elseif debuff == xi.effect.EVASION_DOWN then
        ability:setMsg(xi.msg.basic.DESPOIL_EVA_DOWN)
        power = 30
    elseif debuff == xi.effect.ACCURACY_DOWN then
        ability:setMsg(xi.msg.basic.DESPOIL_ACC_DOWN)
        power = 20
    elseif debuff == xi.effect.SLOW then
        ability:setMsg(xi.msg.basic.DESPOIL_SLOW)

        local dMND = player:getStat(xi.mod.MND) - target:getStat(xi.mod.MND)

        if dMND >= 0 then
            power = 2 * dMND + 1500
        else
            power = dMND + 1500
        end

        power = utils.clamp(power, 750, 3000)
    end

    return power
end

-----------------------------------
-- Ability Check Functions
-----------------------------------
xi.job_utils.thief.checkAccomplice = function(player, target, ability)
    if target == nil or target:getID() == player:getID() or not target:isPC() then
        return xi.msg.basic.CANNOT_ON_THAT_TARG, 0
    else
        return 0, 0
    end
end

xi.job_utils.thief.checkCollaborator = function(player, target, ability)
    if target == nil or target:getID() == player:getID() or not target:isPC() then
        return xi.msg.basic.CANNOT_ON_THAT_TARG, 0
    else
        return 0, 0
    end
end

xi.job_utils.thief.checkDespoil = function(player, target, ability)
    if player:getObjType() == xi.objType.TRUST then -- Trust
        if
            player:getMaster():getFreeSlotsCount() == 0 or
            not target:getDespoilItem()
        then
            return 1, 0
        end
    else -- Player
        if player:getFreeSlotsCount() == 0 then
            return xi.msg.basic.FULL_INVENTORY, 0
        end
    end

    return 0, 0
end

xi.job_utils.thief.checkLarceny = function(player, target, ability)
    ability:setRecast(math.max(0, ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST) * 60))

    return 0, 0
end

xi.job_utils.thief.checkPerfectDodge = function(player, target, ability)
    ability:setRecast(math.max(0, ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST) * 60))

    return 0, 0
end

xi.job_utils.thief.checkSteal = function(player, target, ability)
    if player:getFreeSlotsCount() == 0 then
        return xi.msg.basic.FULL_INVENTORY, 0
    else
        -- JP Recast Reduction
        local jpValue = player:getJobPointLevel(xi.jp.STEAL_RECAST)

        ability:setRecast(ability:getRecast() - 2 * jpValue)

        return 0, 0
    end
end

-----------------------------------
-- Ability Use Functions
-----------------------------------
xi.job_utils.thief.useAccomplice = function(player, target, ability)
    target:transferEnmity(player, 50 + player:getMod(xi.mod.ACC_COLLAB_EFFECT), 20.6)
end

xi.job_utils.thief.useAssassinsCharge = function(player, target, ability)
    local merits = player:getMerit(xi.merit.ASSASSINS_CHARGE)
    local crit   = 0

    if player:getMod(xi.mod.AUGMENTS_ASSASSINS_CHARGE) > 0 then
        crit = merits / 5
    end

    player:addStatusEffect(xi.effect.ASSASSINS_CHARGE, merits - 5, 0, 60, 0, crit)
end

xi.job_utils.thief.useBully = function(player, target, ability)
    local jpValue = player:getJobPointLevel(xi.jp.BULLY_EFFECT)

    target:addStatusEffectEx(xi.effect.DOUBT, xi.effect.INTIMIDATE, 15 + jpValue, 0, 30)

    return xi.effect.INTIMIDATE
end

xi.job_utils.thief.useCollaborator = function(player, target, ability)
    target:transferEnmity(player, 25 + player:getMod(xi.mod.ACC_COLLAB_EFFECT), 20.6)
end

xi.job_utils.thief.useConspirator = function(player, target, ability)
    local subtleBlow = 0
    local accuracy   = 0
    local scale      = 1
    local mob        = player:getTarget()

    if mob then
        local enmityList = mob:getEnmityList()

        if enmityList and #enmityList > 0 then
            if #enmityList < 6 then
                subtleBlow = 20
                accuracy = 15
            elseif #enmityList < 18 then
                subtleBlow = 50
                accuracy = 25
            else
                subtleBlow = 50
                accuracy = 49
            end
        end

        -- See if we should apply the effects to the player at the top of the hate list
        if mob:getTarget() == target then
            scale = player:getMod(xi.mod.AUGMENTS_CONSPIRATOR)
        end
    end

    target:addStatusEffect(xi.effect.CONSPIRATOR, subtleBlow * scale, 0, 60, 0, accuracy * scale)
end

xi.job_utils.thief.useDespoil = function(player, target, ability, action)
    local level         = utils.getActiveJobLevel(player, xi.job.THF)
    local despoilMod    = player:getMod(xi.mod.DESPOIL)
    local despoilChance = 50 + despoilMod * 2 + level - target:getMainLvl() -- Same math as Steal

    -- TODO: Need to verify if there's a message associated with this
    local jpValue = player:getJobPointLevel(xi.jp.DESPOIL_EFFECT)

    if jpValue > 0 and player:getMainJob() == xi.job.THF then
        local tpSteal = jpValue * 0.02
        local mobTP = target:getTP()

        if tpSteal > mobTP then
            tpSteal = mobTP
        end

        target:addTP(-tpSteal)
        player:addTP(tpSteal)
    end

    local stolen = target:getDespoilItem()

    if
        target:isMob() and
        math.random(1, 100) <= despoilChance and
        stolen ~= 0
    then
        if player:getObjType() == xi.objType.TRUST then
            player:getMaster():addItem(stolen)
        else
            player:addItem(stolen)
        end

        target:itemStolen()

        -- Attempt to grab the debuff from the DB
        -- If there isn't a debuff assigned to the item stolen, select one at random
        local debuff = player:getDespoilDebuff(stolen)

        if not debuff then
            debuff = despoilDebuffs[math.random(#despoilDebuffs)]
        end

        local power = processDebuff(player, target, ability, debuff) -- Also sets ability message

        target:addStatusEffect(debuff, power, 0, 90)
    else
        action:setAnimation(target:getID(), 182)
        ability:setMsg(xi.msg.basic.STEAL_FAIL) -- Failed
    end

    return stolen
end

xi.job_utils.thief.useFeint = function(player, target, ability)
    local bonus = player:getMod(xi.mod.AUGMENTS_FEINT) * player:getMerit(xi.merit.FEINT) / 25 -- Divide by the merit value (feint is 25) to get the number of merit points

    -- Subpower is the proc rate bonus for TH procs
    player:addStatusEffect(xi.effect.FEINT, 150 + bonus, 0, 60, 0, player:getMerit(xi.merit.FEINT) - 25) -- -150 Evasion base, 0% base TREASURE_HUNTER_PROC, every merit past 1 gives 25%
end

xi.job_utils.thief.useFlee = function(player, target, ability)
    local duration = 30 + player:getMod(xi.mod.FLEE_DURATION)

    -- TODO: Flee will not override all types of weight effect. Find out which aren't overriden.
    if player:hasStatusEffect(xi.effect.WEIGHT) then
        player:delStatusEffect(xi.effect.WEIGHT)
    end

    player:addStatusEffect(xi.effect.FLEE, 10000, 0, duration)
end

xi.job_utils.thief.useHide = function(player, target, ability)
    local duration = math.random(30, 300)

    duration = duration * (1 + player:getMod(xi.mod.HIDE_DURATION) / 100)

    player:addStatusEffect(xi.effect.HIDE, 1, 0, math.floor(duration * xi.settings.main.SNEAK_INVIS_DURATION_MULTIPLIER))
end

xi.job_utils.thief.useLarceny = function(player, target, ability, action)
    local effectStolen
    local effectID = 0
    local jpValue  = player:getJobPointLevel(xi.jp.LARCENY_EFFECT)

    -- SP Abilities have priority, check if one is present first
    for i = 1, #stealableSPEffects do
        if target:hasStatusEffect(stealableSPEffects[i]) then
            effectStolen = target:getStatusEffect(stealableSPEffects[i])
            break
        end
    end

    -- Default is no SP Ability found
    if effectStolen == nil then
        effectID = player:stealStatusEffect(target)

        local newStatus = player:getStatusEffect(effectID)

        if newStatus then
            newStatus:setDuration((newStatus:getDuration() + jpValue) * 1000)
        end
    -- Copy an SP Ability if found
    else
        local newID       = effectStolen:getEffectType()
        local newIcon     = effectStolen:getIcon()
        local newPower    = effectStolen:getPower()
        local newTick     = effectStolen:getTick()
        local newDuration = effectStolen:getDuration() + jpValue
        local newSubType  = effectStolen:getSubType()
        local newSubPower = effectStolen:getSubPower()
        local newTier     = effectStolen:getTier()
        local newFlags    = effectStolen:getEffectFlags()

        player:addStatusEffectEx(newID, newIcon, newPower, newTick, newDuration, newSubType, newSubPower, newTier, newFlags)
        target:delStatusEffect(newID)

        effectID = newID
    end

    if effectID == 0 then
        action:setAnimation(target:getID(), 182)
        ability:setMsg(xi.msg.basic.STEAL_FAIL)
    end

    target:updateClaim(player)

    return effectID
end

xi.job_utils.thief.useMug = function(player, target, ability, action)
    local thfLevel = utils.getActiveJobLevel(player, xi.job.THF)
    local gil      = 0
    -- TODO: Need to verify if there's a message associated with this
    local jpValue = player:getJobPointLevel(xi.jp.MUG_EFFECT)

    if jpValue > 0 and player:getMainJob() == xi.job.THF then
        local hpSteal = ((player:getStat(xi.mod.AGI) + player:getStat(xi.mod.DEX)) * jpValue) * 0.05
        local mobHP = target:getHP()

        if hpSteal > mobHP then
            hpSteal = mobHP
        end

        target:addHP(-hpSteal)
        player:addHP(hpSteal)
    end

    local mugChance = 90 + thfLevel - target:getMainLvl()

    if
        target:isMob() and
        math.random(1, 100) <= mugChance and
        target:getMobMod(xi.mobMod.MUG_GIL) > 0
    then
        local purse    = target:getMobMod(xi.mobMod.MUG_GIL)
        local fatpurse = target:getGil()

        gil = fatpurse / (8 + math.random(0, 8))

        if gil == 0 then
            gil = fatpurse / 2
        end

        if gil == 0 then
            gil = fatpurse
        end

        if gil > purse then
            gil = purse
        end

        if gil <= 0 then
            ability:setMsg(xi.msg.basic.MUG_FAIL)
        else
            gil = gil * (1 + player:getMod(xi.mod.MUG_EFFECT))

            player:addGil(gil)
            target:setMobMod(xi.mobMod.MUG_GIL, target:getMobMod(xi.mobMod.MUG_GIL) - gil)
            ability:setMsg(xi.msg.basic.MUG_SUCCESS)
        end
    else
        ability:setMsg(xi.msg.basic.MUG_FAIL)
        action:setAnimation(target:getID(), 184)
    end

    return gil
end

xi.job_utils.thief.usePerfectDodge = function(player, target, ability)
    local duration = 30 + player:getMod(xi.mod.PERFECT_DODGE)

    player:addStatusEffect(xi.effect.PERFECT_DODGE, 1, 0, duration)
end

xi.job_utils.thief.useSneakAttack = function(player, target, ability)
    player:addStatusEffect(xi.effect.SNEAK_ATTACK, 1, 0, 60)
end

xi.job_utils.thief.useSteal = function(player, target, ability, action)
    local thfLevel    = utils.getActiveJobLevel(player, xi.job.THF)
    local stolen      = action:getParam(target:getID())
    local stealMod    = player:getMod(xi.mod.STEAL)
    local stealChance = 50 + stealMod * 2 + thfLevel - target:getMainLvl()

    if stolen == 0 then
        stolen = target:getStealItem()
    end

    if target:isMob() and math.random(1, 100) <= stealChance and stolen ~= 0 then
        player:addItem(stolen)
        target:itemStolen()
        ability:setMsg(xi.msg.basic.STEAL_SUCCESS) -- Item stolen successfully
        target:triggerListener('ITEM_STOLEN', target, player, stolen)
        -- Aura Steal does not trigger on successful item steal
        return stolen
    else
        ability:setMsg(xi.msg.basic.STEAL_FAIL) -- Failed to steal
        action:setAnimation(target:getID(), 182)
    end

    -- Attempt Aura steal
    -- local effect = xi.effect.NONE
    if player:hasTrait(xi.trait.AURA_STEAL) then
        local resist = applyResistanceAbility(player, target, xi.element.NONE, 0, 0)
        -- local effectStealSuccess = false
        if resist > 0.0625 then
            local auraStealChance = math.min(player:getMerit(xi.merit.AURA_STEAL), 95)
            if math.random(1, 100) <= auraStealChance then
                local targetShadows = target:getMod(xi.mod.UTSUSEMI)

                stolen = player:stealStatusEffect(target)
                if stolen ~= 0 then
                    ability:setMsg(xi.msg.basic.STEAL_EFFECT)
                    action:setAnimation(target:getID(), 181)

                    if stolen == xi.effect.COPY_IMAGE then
                        if targetShadows > 0 then
                            player:setMod(xi.mod.UTSUSEMI, targetShadows)
                        end
                    end
                end
            -- else
            --     effect = target:dispelStatusEffect()
            end

            -- Try for a second effect if we have the augment
            --[[
            TODO: This implementation is currently broken and inaccurate.  20% chance of a second aura being
            stolen per merit.

            if (effect ~= xi.effect.NONE or stolen ~= 0) and player:getMod(xi.mod.AUGMENTS_AURA_STEAL) > 0 then
                if math.random(1, 100) <= auraStealChance then
                    if stolenEffect2 ~= nil and math.random(1, 100) <= auraStealChance then
                        player:stealStatusEffect(target)
                    else
                        target:dispelStatusEffect()
                    end
                end
            end
            ]]--
        end
    end

    return stolen
end

xi.job_utils.thief.useTrickAttack = function(player, target, ability)
    player:addStatusEffect(xi.effect.TRICK_ATTACK, 1, 0, 60)
end
