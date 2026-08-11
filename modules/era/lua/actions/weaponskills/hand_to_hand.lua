-----------------------------------
-- Date : 2007-11-19 (One day prior to WoTG release)
-----------------------------------
require('modules/module_utils')
-----------------------------------

local m = Module:new('toau_hand_to_hand', xi.pre(xi.expansion.WOTG))

-----------------------------------
-- Combo
-----------------------------------
m:addOverride('xi.actions.weaponskills.combo.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 3
    params.ftpMod  = { 1.00, 1.50, 2.00 }
    params.str_wsc = 0.2
    params.dex_wsc = 0.2

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Shoulder Tackle
-----------------------------------
m:addOverride('xi.actions.weaponskills.shoulder_tackle.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 2
    params.ftpMod  = { 1.00, 1.00, 1.00 }
    params.vit_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    local effectId      = xi.effect.STUN
    local actionElement = xi.element.THUNDER
    local power         = 1
    local maccParams    =
    {
        effectId       = effectId,
        magicalElement = actionElement,
        skillType      = xi.skill.HAND_TO_HAND,
        bonusMacc      = xi.weaponskills.fTP(tp, { 25, 50, 100 }),
    }

    local resistanceRate = xi.combat.magicHitRate.calculateResistRate(player, target, maccParams)

    if xi.data.statusEffect.isResistRateSuccessfull(effectId, resistanceRate, 0) then
        local duration = math.floor(4 * resistanceRate)

        xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)
    end

    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- One Inch Punch
-----------------------------------
m:addOverride('xi.actions.weaponskills.one_inch_punch.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params          = {}
    params.numHits        = 2
    params.ftpMod         = { 1.00, 1.00, 1.00 }
    params.vit_wsc        = 0.4
    params.ignoredDefense = { 0.00, 0.375, 0.75 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Backhand Blow
-----------------------------------
m:addOverride('xi.actions.weaponskills.backhand_blow.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.numHits    = 2
    params.ftpMod     = { 1.00, 1.00, 1.00 }
    params.str_wsc    = 0.3
    params.dex_wsc    = 0.3
    params.critVaries = { 0.30, 0.63, 0.96 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Raging Fists
-----------------------------------
m:addOverride('xi.actions.weaponskills.raging_fists.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 5
    params.ftpMod  = { 1.00, 1.50, 2.00 }
    params.str_wsc = 0.2
    params.dex_wsc = 0.2

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Spinning Attack
-----------------------------------
m:addOverride('xi.actions.weaponskills.spinning_attack.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 2
    params.ftpMod  = { 1.00, 1.00, 1.00 }
    params.str_wsc = 0.35

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Howling Fist
-----------------------------------
m:addOverride('xi.actions.weaponskills.howling_fist.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params     = {}
    params.numHits   = 2
    params.ftpMod    = { 2.50, 2.75, 3.00 }
    params.atkVaries = { 1.50, 1.50, 1.50 }
    params.str_wsc   = 0.2
    params.vit_wsc   = 0.5

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Dragon Kick
-----------------------------------
m:addOverride('xi.actions.weaponskills.dragon_kick.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 2
    params.ftpMod  = { 2.00, 2.75, 3.50 }
    params.str_wsc = 0.5
    params.vit_wsc = 0.5
    params.kick    = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Asuran Fists
-----------------------------------
m:addOverride('xi.actions.weaponskills.asuran_fists.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params     = {}
    params.numHits   = 8
    params.ftpMod    = { 1.00, 1.00, 1.00 }
    params.str_wsc   = 0.1
    params.vit_wsc   = 0.1
    params.accVaries = { 0, 30, 50 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Final Heaven
-----------------------------------
m:addOverride('xi.actions.weaponskills.final_heaven.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 2
    params.ftpMod  = { 3.00, 3.00, 3.00 }
    params.vit_wsc = 0.6

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.RELIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Ascetic's Fury
-----------------------------------
m:addOverride('xi.actions.weaponskills.ascetics_fury.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.numHits    = 2
    params.ftpMod     = { 1.00, 1.00, 1.00 }
    params.atkVaries  = { 2.00, 2.00, 2.00 }
    params.critVaries = { 0.20, 0.40, 0.80 }
    params.str_wsc    = 0.5
    params.vit_wsc    = 0.5

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Stringing Pummel
-----------------------------------
m:addOverride('xi.actions.weaponskills.stringing_pummel.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.numHits    = 6
    params.ftpMod     = { 0.75, 0.75, 0.75 }
    params.str_wsc    = 0.32
    params.vit_wsc    = 0.32
    params.critVaries = { 0.10, 0.22, 0.36 }

    -- Apply Aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)
