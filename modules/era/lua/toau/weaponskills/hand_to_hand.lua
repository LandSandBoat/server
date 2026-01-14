-----------------------------------
-- Date : 2007-11-19 (One day prior to WoTG release)
-----------------------------------
require('modules/module_utils')
-----------------------------------

local m = Module:new('toau_hand_to_hand')

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
    local skillType     = xi.skill.HAND_TO_HAND
    local skillRank     = player:getSkillRank(skillType)
    local resist        = xi.combat.magicHitRate.calculateResistRate(player, target, 0, skillType, skillRank, actionElement, 0, effectId, 0)
    local duration      = math.floor(tp / 500 * resist)
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

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
    params.ignoredDefense = { 0.00, 0.30, 0.50 }

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
    params.critVaries = { 0.40, 0.60, 0.80 }

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
    params.critVaries = { 0.10, 0.20, 0.40 }
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
    params.critVaries = { 0.15, 0.30, 0.45 }

    -- Apply Aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

return m
