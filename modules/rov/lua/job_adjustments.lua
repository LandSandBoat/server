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
    player:addStatusEffect(xi.effect.FOCUS, focusMod, 0, 120)

    return xi.effect.FOCUS
end)

-- Dodge: Revert duration from 30 to 120 seconds
m:addOverride('xi.job_utils.monk.useDodge', function(player, target, ability)
    local dodgeMod = target:getMod(xi.mod.DODGE_EFFECT)
    player:addStatusEffect(xi.effect.DODGE, dodgeMod, 0, 120)

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

        player:addStatusEffect(xi.effect.REGEN, 10, 0, merits, 0, 0, 1)
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
--     player:addStatusEffect(xi.effect.FOOTWORK, kickDmg, 0, 300, 0, kickAttPercent)

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

return m
