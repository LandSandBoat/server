-----------------------------------
-- Date : 2007-11-19 (One day prior to WoTG release)
-----------------------------------
require('modules/module_utils')
-----------------------------------

local m = Module:new('toau_axe')

-----------------------------------
-- Raging Axe
-----------------------------------
m:addOverride('xi.actions.weaponskills.raging_axe.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 2
    params.ftpMod  = { 1.00, 1.50, 2.00 }
    params.str_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Smash Axe
-----------------------------------
m:addOverride('xi.actions.weaponskills.smash_axe.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 1.00, 1.00, 1.00 }
    params.str_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.STUN
    local actionElement = xi.element.THUNDER
    local power         = 1
    local skillType     = xi.skill.AXE
    local resist        = xi.combat.magicHitRate.calculateResistRate(player, target, 0, skillType, 0, actionElement, 0, effectId, 0)
    local duration      = math.floor(tp / 500 * resist)
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Gale Axe
-----------------------------------
m:addOverride('xi.actions.weaponskills.gale_axe.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 1.00, 1.00, 1.00 }
    params.str_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.CHOKE
    local actionElement = xi.element.WIND
    local power         = 5
    local skillType     = xi.skill.AXE
    local resist        = xi.combat.magicHitRate.calculateResistRate(player, target, 0, skillType, 0, actionElement, 0, effectId, 0)
    local duration      = math.floor(90 * resist)
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Avalanche Axe
-----------------------------------
m:addOverride('xi.actions.weaponskills.avalanche_axe.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 1.50, 2.00, 2.50 }
    params.str_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Spinning Axe
-----------------------------------
m:addOverride('xi.actions.weaponskills.spinning_axe.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 2.00, 2.50, 3.00 }
    params.str_wsc = 0.35

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Rampage
-----------------------------------
m:addOverride('xi.actions.weaponskills.rampage.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.numHits    = 5
    params.ftpMod     = { 0.50, 0.50, 0.50 }
    params.str_wsc    = 0.3
    params.critVaries = { 0.00, 0.20, 0.40 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Calamity
-----------------------------------
m:addOverride('xi.actions.weaponskills.calamity.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 1.00, 1.50, 4.00 }
    params.str_wsc = 0.32
    params.vit_wsc = 0.32

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Mistral Axe
-----------------------------------
m:addOverride('xi.actions.weaponskills.mistral_axe.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 2.50, 3.00, 3.50 }
    params.str_wsc = 0.5

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Decimation
-----------------------------------
m:addOverride('xi.actions.weaponskills.decimation.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params     = {}
    params.numHits   = 3
    params.ftpMod    = { 1.25, 1.25, 1.25 }
    params.str_wsc   = 0.5
    params.accVaries = {    0,   30,   50 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Onslaught
-----------------------------------
m:addOverride('xi.actions.weaponskills.onslaught.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 2.75, 2.75, 2.75 }
    params.dex_wsc = 0.6

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.RELIC)
    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.ACCURACY_DOWN
    local actionElement = xi.element.EARTH
    local power         = 30
    local skillType     = xi.skill.AXE
    local resist        = xi.combat.magicHitRate.calculateResistRate(player, target, 0, skillType, 0, actionElement, 0, effectId, 0)
    local duration      = math.floor(120 * resist)
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Primal Rend
-----------------------------------
m:addOverride('xi.actions.weaponskills.primal_rend.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.ftpMod     = { 4.00, 4.25, 4.75 }
    params.chr_wsc    = 0.3
    params.ele        = xi.element.LIGHT
    params.skill      = xi.skill.AXE
    params.includemab = true
    params.dStat      = xi.mod.CHR

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

return m
