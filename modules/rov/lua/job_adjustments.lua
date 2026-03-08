-----------------------------------
-- Module: Job Adjustments (Rhapsodies of Vana'diel Era)
-- Desc: Removes traits/abilities/effects that were added to jobs during the RoV era
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/52969
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('rov_job_adjustments')

-----------------------------------
-- Monk
-----------------------------------

-- Focus: Revert to flat +20 ACC only
m:addOverride('xi.effects.focus.onEffectGain', function(target, effect)
    local bonusPower = effect:getPower()

    effect:addMod(xi.mod.ACC, 20 + bonusPower)
end)

-- Dodge: Revert to flat +20 EVA only
m:addOverride('xi.effects.dodge.onEffectGain', function(target, effect)
    local bonusPower = effect:getPower()

    effect:addMod(xi.mod.EVA, 20 + bonusPower)
end)

-- Focus: Revert duration from 30 to 120 seconds
m:addOverride('xi.job_utils.monk.useFocus', function(player, target, ability)
    local focusMod = target:getMod(xi.mod.FOCUS_EFFECT)
    player:addStatusEffect(xi.effect.FOCUS, { power = focusMod, duration = 120, origin = player })

    return xi.effect.FOCUS
end)

-- Dodge: Revert duration from 30 to 120 seconds
m:addOverride('xi.job_utils.monk.useDodge', function(player, target, ability)
    local dodgeMod = target:getMod(xi.mod.DODGE_EFFECT)
    player:addStatusEffect(xi.effect.DODGE, { power = dodgeMod, duration = 120, origin = player })

    return xi.effect.DODGE
end)

-- Chakra: Revert to VIT * 2 healing only
m:addOverride('xi.job_utils.monk.useChakra', function(player, target, ability)
    local chakraRemoval = player:getMod(xi.mod.CHAKRA_REMOVAL)

    -- Status effect removal (unchanged)
    local chakraStatusEffects =
    {
        POISON    = 0,    -- Removed by default
        BLINDNESS = 0,    -- Removed by default
        PARALYSIS = 1,
        DISEASE   = 2,
        PLAGUE    = 4,
    }

    for k, v in pairs(chakraStatusEffects) do
        if bit.band(chakraRemoval, v) == v then
            player:delStatusEffect(xi.effect[k])
        end
    end

    local chakraMultiplier  = 1 + player:getMod(xi.mod.CHAKRA_MULT) / 100
    local maxRecoveryAmount = (player:getStat(xi.mod.VIT) * 2) * chakraMultiplier
    local recoveryAmount    = math.min(player:getMaxHP() - player:getHP(), maxRecoveryAmount)

    player:setHP(player:getHP() + recoveryAmount)

    local merits = player:getMerit(xi.merit.INVIGORATE)
    if merits > 0 then
        if player:hasStatusEffect(xi.effect.REGEN) then
            player:delStatusEffect(xi.effect.REGEN)
        end

        player:addStatusEffect(xi.effect.REGEN, { power = 10, duration = merits, origin = player, tier = 1 })
    end

    return recoveryAmount
end)

-- Revert Footwork to original June 2008 implementation
-- Source: https://wiki.ffo.jp/html/15342.html
-- TODO:
--   Normal attacks replaced with kicks only
--   Max attacks per round capped at 2
--   Special subtle blow that calculates enemy TP gain as if Monk's delay is 240
--   Hundred Fists disables Store TP and Attack bonuses from Footwork
-- m:addOverride('xi.job_utils.monk.useFootwork', function(player, target, ability)
--     -- Pre-RoV: base kick damage of 20 only, no weapon damage added
--     local kickDmg        = 20
--     local kickAttPercent = 25 + player:getMod(xi.mod.FOOTWORK_ATT_BONUS)

--     -- Duration changed from 60 seconds to 300 seconds (5 minutes)
--     player:addStatusEffect(xi.effect.FOOTWORK, { power = kickDmg, duration = 300, origin = player, subPower = kickAttPercent })

--     return xi.effect.FOOTWORK
-- end)

-- m:addOverride('xi.effects.footwork.onEffectGain', function(target, effect)
--     -- Kick damage: bare-hand D + 20 (passed as effect power, no weapon damage)
--     effect:addMod(xi.mod.KICK_DMG, effect:getPower())
--     effect:addMod(xi.mod.STORETP, 180)
--     effect:addMod(xi.mod.HASTE_MAGIC, -6000)
-- end)

-----------------------------------
-- Dark Knight
-----------------------------------

-- Dread Spikes: Revert duration from 3 minutes to 1 minute.
-- Source: https://forum.square-enix.com/ffxi/threads/48564-Sep-16-2015-%28JST%29-Version-Update
m:addOverride('xi.effects.dread_spikes.onEffectGain', function(target, effect)
    super(target, effect)
    effect:setDuration(60000)
end)

-- TODO Absorb-STAT: Add decay tick and set 90 second duration to boost effects
-- TODO Drain II: Set duration of max HP boost to 60 seconds.
-- Source:
--   Decay Removal: http://forum.square-enix.com/ffxi/threads/46531-Mar-26-2015-%28JST%29-Version-Update
--   Duration Change: https://forum.square-enix.com/ffxi/threads/48564-Sep-16-2015-%28JST%29-Version-Update

-----------------------------------
-- Ranger
-----------------------------------

-- Eagle Eye Shot: Revert shadow bypass
-- Source: https://forum.square-enix.com/ffxi/threads/47481-Jun-25-2015-%28JST%29-Version-Update
m:addOverride('xi.job_utils.ranger.useEagleEyeShot', function(player, target, ability, action)
    if player:getWeaponSkillType(xi.slot.RANGED) == xi.skill.MARKSMANSHIP then
        action:setAnimation(target:getID(), action:getAnimation(target:getID()) + 1)
    end

    local params = {}

    params.numHits = 1

    -- TP params.
    local tp          = 1000 -- to ensure ftp multiplier is applied
    params.ftpMod     = { 5.0, 5.0, 5.0 }
    params.critVaries = { 0.0, 0.0, 0.0 }

    -- Stat params.
    params.str_wsc = 0
    params.dex_wsc = 0
    params.vit_wsc = 0
    params.agi_wsc = 0
    params.int_wsc = 0
    params.mnd_wsc = 0
    params.chr_wsc = 0

    params.enmityMult = 0.5

    -- Job Point Bonus Damage
    local jpValue = player:getJobPointLevel(xi.jp.EAGLE_EYE_SHOT_EFFECT)
    player:addMod(xi.mod.ALL_WSDMG_ALL_HITS, jpValue * 3)

    local damage, _, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, 0, params, tp, action, true)

    -- Set the message id ourselves
    if tpHits + extraHits > 0 then
        action:messageID(target:getID(), xi.msg.basic.JA_DAMAGE)
    else
        action:messageID(target:getID(), xi.msg.basic.JA_MISS_2)
    end

    return damage
end)

-----------------------------------
-- Ninja
-----------------------------------

-- Yonin: Remove extra enmity bonus from Utsusemi spells and Yonin merits
m:addOverride('xi.effects.yonin.onEffectGain', function(target, effect)
    effect:addMod(xi.mod.ACC, -effect:getPower())
    effect:addMod(xi.mod.NINJA_TOOL, effect:getPower())
    effect:addMod(xi.mod.ENMITY, effect:getPower())
end)

-- San Spells: Add +5 Magic Attack and +5 Magic Accuracy per merit rank
-- Source: https://forum.square-enix.com/ffxi/threads/55525-June.-10-2019-%28JST%29-Version-Update
local sanSpellOverrides =
{
    { path = 'xi.actions.spells.ninjutsu.katon_san.onSpellCast',  merit = xi.merit.KATON_SAN  },
    { path = 'xi.actions.spells.ninjutsu.hyoton_san.onSpellCast', merit = xi.merit.HYOTON_SAN },
    { path = 'xi.actions.spells.ninjutsu.huton_san.onSpellCast',  merit = xi.merit.HUTON_SAN  },
    { path = 'xi.actions.spells.ninjutsu.doton_san.onSpellCast',  merit = xi.merit.DOTON_SAN  },
    { path = 'xi.actions.spells.ninjutsu.raiton_san.onSpellCast', merit = xi.merit.RAITON_SAN },
    { path = 'xi.actions.spells.ninjutsu.suiton_san.onSpellCast', merit = xi.merit.SUITON_SAN },
}

for _, entry in ipairs(sanSpellOverrides) do
    m:addOverride(entry.path, function(caster, target, spell)
        local meritBonus = caster:getMerit(entry.merit)
        caster:addMod(xi.mod.MATT, meritBonus)
        caster:addMod(xi.mod.MACC, meritBonus)

        local damage = super(caster, target, spell)

        caster:delMod(xi.mod.MATT, meritBonus)
        caster:delMod(xi.mod.MACC, meritBonus)

        return damage
    end)
end

-----------------------------------
-- Dragoon
-----------------------------------

-- Healing Breath: Revert to consume TP and formula based on TP usage
-- Source: https://forum.square-enix.com/ffxi/threads/52969
m:addOverride('xi.job_utils.dragoon.useHealingBreath', function(wyvern, target, skill, action)
    local healingBreathTable =
    {
        --                                    { base, multiplier }
        [xi.jobAbility.HEALING_BREATH]     = {  8, 25 },
        [xi.jobAbility.HEALING_BREATH_II]  = { 24, 38 },
        [xi.jobAbility.HEALING_BREATH_III] = { 42, 45 },
        [xi.jobAbility.HEALING_BREATH_IV]  = { 60, 53 },
    }

    local master              = wyvern:getMaster()
    local deepMult            = xi.job_utils.dragoon.getDeepBreathingBonus(wyvern, master, true)
    local jobPointBonus       = master:getJobPointLevel(xi.jp.WYVERN_BREATH_EFFECT) * 10
    local breathAugmentsBonus = 1 + master:getMod(xi.mod.UNCAPPED_WYVERN_BREATH) / 100
    local gear                = master:getMod(xi.mod.WYVERN_BREATH) -- Master gear that enhances breath
    local base                = healingBreathTable[skill:getID()][1]
    local baseMultiplier      = healingBreathTable[skill:getID()][2]

    -- TP bonus: wyvern TP enhances healing multiplier
    local tpBonus = math.floor(wyvern:getTP() / 200) / 1.165

    -- gear cap of 64/256 in multiplier
    local multiplier      = (baseMultiplier + math.min(gear, 64) + math.floor(deepMult) + tpBonus) / 256
    local curePower       = math.floor(wyvern:getMaxHP() * multiplier) + base + jobPointBonus * breathAugmentsBonus
    local totalHPRestored = target:addHP(curePower)

    -- Consume wyvern TP after calculating breath power
    wyvern:setTP(0)

    skill:setMsg(xi.msg.basic.JA_RECOVERS_HP_2)

    -- Also cure the Wyvern if Spirit Bond is up
    if master:hasStatusEffect(xi.effect.SPIRIT_BOND) then
        local totalWyvernHPRestored = wyvern:addHP(curePower)

        action:addAdditionalTarget(wyvern:getID())
        action:setAnimation(wyvern:getID(), action:getAnimation(target:getID()))
        action:messageID(wyvern:getID(), xi.msg.basic.SELF_HEAL_SECONDARY)
        action:param(wyvern:getID(), totalWyvernHPRestored)
    end

    if master:getMod(xi.mod.ENHANCES_STRAFE) > 0 then
        local strafeTP = master:getMerit(xi.merit.STRAFE_EFFECT) * 50
        wyvern:addTP(strafeTP) -- add 50 TP per merit with augmented AF2 legs
    end

    return totalHPRestored
end)

-- Spirit Link: Revert to pre-September 2015 healing formula.
-- Source: https://forum.square-enix.com/ffxi/threads/48564-Sep-16-2015-%28JST%29-Version-Update
-- Formula taken from: https://wiki.ffo.jp/html/15079.html
m:addOverride('xi.job_utils.dragoon.useSpiritLink', function(player, target, ability, action)
    local wyvern      = player:getPet()
    local playerHP    = player:getHP()
    local petTP       = wyvern:getTP()
    local regenAmount = player:getMainLvl() / 3 -- level/3 tic regen

    xi.job_utils.dragoon.checkForRemovableEffectsOnSpiritLink(player, wyvern)

    -- Empathy: copy status effects and grant wyvern EXP
    xi.job_utils.dragoon.applyEmpathyBonus(player, wyvern)

    wyvern:addStatusEffect(xi.effect.REGEN, { power = regenAmount, duration = 90, origin = player, tick = 3 }) -- 90 seconds of regen
    player:addTP(petTP / 2) -- add half wyvern tp to you
    wyvern:delTP(petTP / 2) -- remove half tp from wyvern

    -- Calculate drain amount.
    local drainamount = 0

    if wyvern:getHP() ~= wyvern:getMaxHP() then
        drainamount = (math.random(25, 35) / 100) * playerHP
        drainamount = drainamount * (1 - (0.01 * player:getJobPointLevel(xi.jp.SPIRIT_LINK_EFFECT)))
    end

    -- Handle Stoneskin.
    local stoneskinPower = 0

    if player:hasStatusEffect(xi.effect.STONESKIN) then
        stoneskinPower = player:getMod(xi.mod.STONESKIN)

        -- If stoneskin is more powerfull than the amount to be drained.
        if stoneskinPower > drainamount then
            local effect = player:getStatusEffect(xi.effect.STONESKIN)
            effect:setPower(effect:getPower() - drainamount) -- Fixes the status effect so when it ends it uses the new power instead of old.
            player:delMod(xi.mod.STONESKIN, drainamount)     -- Removes the amount from the mod.

        -- If stoneskin is as powerful or less than the amount to be drained.
        else
            player:delStatusEffect(xi.effect.STONESKIN)
        end
    end

    -- Handle master damage and pet healing.
    player:takeDamage(drainamount - stoneskinPower)

    local playerMND = player:getStat(xi.mod.MND)
    local alpha     = wyvern:getMainLvl() * 0.7
    local healPet   = (drainamount + playerMND + alpha) * 2

    if player:getEquipID(xi.slot.HEAD) == xi.item.DRACHEN_ARMET_P1 then
        healPet = healPet + 15
    end

    -- Spirit Link is self target but reports effect on Wyvern.
    action:ID(player:getID(), wyvern:getID())

    return wyvern:addHP(healPet) -- add the hp to wyvern
end)

-- Wyvern EXP: Revert WS Damage bonus from wyvern level-ups
-- Source: https://forum.square-enix.com/ffxi/threads/55997-October.-10-2019-%28JST%29-Version-Update
m:addOverride('xi.job_utils.dragoon.addWyvernExp', function(player, exp)
    local wyvern      = player:getPet()
    local prevExp     = wyvern:getLocalVar('wyvern_exp')
    local numLevelUps = 0

    if prevExp < 1000 then
        local currentExp = exp
        if prevExp + currentExp > 1000 then
            currentExp = 1000 - prevExp
        end

        numLevelUps = math.floor((prevExp + currentExp) / 200) - math.floor(prevExp / 200)

        if numLevelUps ~= 0 then
            local wyvernAttributeIncreaseEffectJP = player:getJobPointLevel(xi.jp.WYVERN_ATTR_BONUS)
            local wyvernBonusDA = player:getMod(xi.mod.WYVERN_ATTRIBUTE_DA)

            wyvern:addMod(xi.mod.ACC, 6 * numLevelUps)
            wyvern:addMod(xi.mod.HPP, 6 * numLevelUps)
            wyvern:addMod(xi.mod.ATTP, 5 * numLevelUps)

            wyvern:updateHealth()
            wyvern:setHP(wyvern:getMaxHP())

            player:messageBasic(xi.msg.basic.STATUS_INCREASED, 0, 0, wyvern)

            player:addMod(xi.mod.ATT, wyvernAttributeIncreaseEffectJP * numLevelUps)
            player:addMod(xi.mod.DEF, wyvernAttributeIncreaseEffectJP * numLevelUps)
            player:addMod(xi.mod.ATTP, 4 * numLevelUps)
            player:addMod(xi.mod.DEFP, 4 * numLevelUps)
            player:addMod(xi.mod.HASTE_ABILITY, 200 * numLevelUps)
            player:addMod(xi.mod.DOUBLE_ATTACK, wyvernBonusDA * numLevelUps)
        end

        wyvern:setLocalVar('wyvern_exp', prevExp + exp)
        wyvern:setLocalVar('level_Ups', wyvern:getLocalVar('level_Ups') + numLevelUps)
    end

    return numLevelUps
end)

-- Wyvern Level Removal: Match addWyvernExp by omitting ALL_WSDMG_ALL_HITS
m:addOverride('xi.pets.wyvern.removeWyvernLevels', function(mob)
    local master  = mob:getMaster()
    local numLvls = mob:getLocalVar('level_Ups')

    if numLvls ~= 0 then
        local wyvernAttributeIncreaseEffectJP = master:getJobPointLevel(xi.jp.WYVERN_ATTR_BONUS)
        local wyvernBonusDA = master:getMod(xi.mod.WYVERN_ATTRIBUTE_DA)

        master:delMod(xi.mod.ATT, wyvernAttributeIncreaseEffectJP * numLvls)
        master:delMod(xi.mod.DEF, wyvernAttributeIncreaseEffectJP * numLvls)
        master:delMod(xi.mod.ATTP, 4 * numLvls)
        master:delMod(xi.mod.DEFP, 4 * numLvls)
        master:delMod(xi.mod.HASTE_ABILITY, 200 * numLvls)
        master:delMod(xi.mod.DOUBLE_ATTACK, wyvernBonusDA * numLvls)
    end
end)

return m
