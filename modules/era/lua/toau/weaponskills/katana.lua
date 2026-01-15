-----------------------------------
-- Date : 2007-11-19 (One day prior to WoTG release)
-----------------------------------
require('modules/module_utils')
-----------------------------------

local m = Module:new('toau_katana')

-----------------------------------
-- Blade: Rin
-----------------------------------
m:addOverride('xi.actions.weaponskills.blade_rin.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.numHits    = 1
    params.ftpMod     = { 1.00, 1.00, 1.00 }
    params.str_wsc    = 0.2
    params.dex_wsc    = 0.2
    params.critVaries = { 0.40, 0.60, 0.80 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Blade: Retsu
-----------------------------------
m:addOverride('xi.actions.weaponskills.blade_retsu.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 2
    params.ftpMod  = { 1.00, 1.00, 1.00 }
    params.str_wsc = 0.2
    params.dex_wsc = 0.2

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.PARALYSIS
    local actionElement = xi.element.ICE
    local power         = utils.clamp(30 + 3 * (player:getMainLvl() - target:getMainLvl()), 5, 35)
    local skillType     = xi.skill.KATANA
    local resist        = xi.combat.magicHitRate.calculateResistRate(player, target, 0, skillType, 0, actionElement, 0, effectId, 0)
    local duration      = math.floor(xi.weaponskills.fTP(tp, { 30, 60, 120 }) * resist)
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Blade: Teki
-----------------------------------
m:addOverride('xi.actions.weaponskills.blade_teki.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.numHits    = 1
    params.ftpMod     = { 0.50, 0.75, 1.00 }
    params.str_wsc    = 0.2
    params.int_wsc    = 0.2
    params.hybridWS   = true
    params.ele        = xi.element.WATER
    params.skill      = xi.skill.KATANA
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Blade: To
-----------------------------------
m:addOverride('xi.actions.weaponskills.blade_to.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.numHits    = 1
    params.ftpMod     = { 0.50, 0.75, 1.00 }
    params.str_wsc    = 0.3
    params.int_wsc    = 0.3
    params.hybridWS   = true
    params.ele        = xi.element.ICE
    params.skill      = xi.skill.KATANA
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Blade: Chi
-----------------------------------
m:addOverride('xi.actions.weaponskills.blade_chi.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.numHits    = 2
    params.ftpMod     = { 0.50, 0.75, 1.00 }
    params.str_wsc    = 0.3
    params.int_wsc    = 0.3
    params.hybridWS   = true
    params.ele        = xi.element.EARTH
    params.skill      = xi.skill.KATANA
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Blade: Ei
-----------------------------------
m:addOverride('xi.actions.weaponskills.blade_ei.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.ftpMod     = { 1.00, 1.50, 2.00 }
    params.str_wsc    = 0.3
    params.int_wsc    = 0.3
    params.ele        = xi.element.DARK
    params.skill      = xi.skill.KATANA
    params.includemab = true
    params.dStat      = xi.mod.INT

    local damage, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, false, damage
end)

-----------------------------------
-- Blade: Jin
-----------------------------------
m:addOverride('xi.actions.weaponskills.blade_jin.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.numHits    = 3
    params.ftpMod     = { 1.00, 1.00, 1.00 }
    params.str_wsc    = 0.3
    params.dex_wsc    = 0.3
    params.critVaries = { 0.00, 0.20, 0.40 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Blade: Ten
-----------------------------------
m:addOverride('xi.actions.weaponskills.blade_ten.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 2.50, 2.75, 3.00 }
    params.str_wsc = 0.3
    params.dex_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Blade: Ku
-----------------------------------
m:addOverride('xi.actions.weaponskills.blade_ku.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params     = {}
    params.numHits   = 5
    params.ftpMod    = { 1.00, 1.00, 1.00 }
    params.str_wsc   = 0.1
    params.dex_wsc   = 0.1
    params.accVaries = { 0, 30, 50 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Blade: Metsu
-----------------------------------
m:addOverride('xi.actions.weaponskills.blade_metsu.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 3.00, 3.00, 3.00 }
    params.dex_wsc = 0.6

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.RELIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.PARALYSIS
    local actionElement = xi.element.ICE
    local power         = 10
    local skillType     = xi.skill.KATANA
    local resist        = xi.combat.magicHitRate.calculateResistRate(player, target, 0, skillType, 0, actionElement, 0, effectId, 0)
    local duration      = math.floor(60 * resist)
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Blade: Kamu
-----------------------------------
m:addOverride('xi.actions.weaponskills.blade_kamu.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params     = {}
    params.numHits   = 1
    params.ftpMod    = { 1.00, 1.00, 1.00 }
    params.str_wsc   = 0.5
    params.int_wsc   = 0.5
    params.atkVaries = { 1.30, 1.30, 1.30 }

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.ACCURACY_DOWN
    local actionElement = xi.element.EARTH
    local power         = 10
    local skillType     = xi.skill.KATANA
    local resist        = xi.combat.magicHitRate.calculateResistRate(player, target, 0, skillType, 0, actionElement, 0, effectId, 0)
    local duration      = math.floor(6 * tp / 100 * resist)
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

return m
