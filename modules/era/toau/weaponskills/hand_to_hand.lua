-----------------------------------
-- ToAU era hand-to-hand weaponskill module
-- Sets fTP, WSC and additional effects to their ToAU values
-- Target date: 2007-11-19 (one day prior to WotG release)
-----------------------------------
require('modules/module_utils')
-----------------------------------

local m = Module:new('toau_weaponskills_hand_to_hand')

-- Combo
m:addOverride('xi.actions.weaponskills.combo.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 3
    params.ftpMod  = { 1.0, 1.5, 2.0 }
    params.str_wsc = 0.2
    params.dex_wsc = 0.2

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Shoulder Tackle
m:addOverride('xi.actions.weaponskills.shoulder_tackle.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod  = { 1.0, 1.0, 1.0 }
    params.vit_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    local effectId      = xi.effect.STUN
    local actionElement = xi.element.THUNDER
    local power         = 1
    local duration      = math.floor(tp / 500 * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-- One Inch Punch
m:addOverride('xi.actions.weaponskills.one_inch_punch.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod  = { 1.0, 1.0, 1.0 }
    params.vit_wsc = 0.4
    params.ignoredDefense = { 0.0, 0.3, 0.5 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Backhand Blow
m:addOverride('xi.actions.weaponskills.backhand_blow.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod  = { 1.0, 1.5, 2.0 }
    params.str_wsc = 0.3
    params.dex_wsc = 0.3
    params.critVaries = { 0.4, 0.6, 0.8 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Raging Fists
m:addOverride('xi.actions.weaponskills.raging_fists.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 5
    params.ftpMod  = { 1.0, 1.5, 2.0 }
    params.str_wsc = 0.2
    params.dex_wsc = 0.2

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Spinning Attack
m:addOverride('xi.actions.weaponskills.spinning_attack.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod  = { 1.0, 1.0, 1.0 }
    params.str_wsc = 0.35

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Howling Fist
m:addOverride('xi.actions.weaponskills.howling_fist.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits   = 2
    params.ftpMod    = { 2.5, 2.75, 3.0 }
    params.atkVaries = { 1.5, 1.5, 1.5 } -- https://w.atwiki.jp/studiogobli/pages/93.html
    params.str_wsc   = 0.2
    params.vit_wsc   = 0.5

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Dragon Kick
m:addOverride('xi.actions.weaponskills.dragon_kick.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod  = { 2.0, 2.75, 3.5 }
    params.str_wsc = 0.5
    params.vit_wsc = 0.5
    params.kick    = true -- https://www.bluegartr.com/threads/112776-Dev-Tracker-Findings-Posts-%28NO-DISCUSSION%29?p=6712150&viewfull=1#post6712150

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Asuran Fists
m:addOverride('xi.actions.weaponskills.asuran_fists.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits   = 8
    params.ftpMod    = { 1.0, 1.0, 1.0 }
    params.str_wsc   = 0.1
    params.vit_wsc   = 0.1
    params.accVaries = { 1.0, 1.0, 1.0 } -- TODO: Convert to flat accuracy bonus

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Final Heaven
m:addOverride('xi.actions.weaponskills.final_heaven.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod  = { 3.0, 3.0, 3.0 }
    params.vit_wsc = 0.6

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.RELIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

m:addOverride('xi.actions.weaponskills.ascetics_fury.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits    = 2
    params.ftpMod     = { 1, 1, 1 }
    params.atkVaries  = { 2.0, 2.0, 2.0 } -- https://www.bluegartr.com/threads/104123-Weapon-Skills?p=5045281&viewfull=1#post5045281
    params.critVaries = { 0.1, 0.2, 0.4 }
    params.str_wsc    = 0.5
    params.vit_wsc    = 0.5

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

m:addOverride('xi.actions.weaponskills.stringing_pummel.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits    = 6
    params.ftpMod     = { 0.75, 0.75, 0.75 }
    params.str_wsc    = 0.32
    params.vit_wsc    = 0.32
    params.critVaries = { 0.15, 0.30, 0.45 } -- TODO: Needs verification

    -- Apply Aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

return m
