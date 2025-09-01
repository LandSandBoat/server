-----------------------------------
-- ToAU era great katana weaponskill module
-- Sets fTP, WSC and additional effects to their ToAU values
-- Target date: 2007-11-19 (one day prior to WotG release)
-----------------------------------
require('modules/module_utils')
-----------------------------------

local m = Module:new('toau_weaponskills_great_katana')

-- Tachi: Enpi
m:addOverride('xi.actions.weaponskills.tachi_enpi.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod = { 1.0, 1.5, 2.0 }
    params.str_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Tachi: Hobaku
m:addOverride('xi.actions.weaponskills.tachi_hobaku.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 1, 1, 1 }
    params.str_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.STUN
    local actionElement = xi.element.LIGHT
    local power         = 1
    local duration      = math.floor(3 * tp / 100 * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-- Tachi: Goten
m:addOverride('xi.actions.weaponskills.tachi_goten.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits    = 1
    params.ftpMod     = { 0.5, 0.75, 1.0 }
    params.str_wsc    = 0.3
    params.hybridWS   = true
    params.ele        = xi.element.THUNDER
    params.skill      = xi.skill.GREAT_KATANA
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Tachi: Kagero
m:addOverride('xi.actions.weaponskills.tachi_kagero.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits    = 1
    params.ftpMod     = { 0.5, 0.75, 1.0 }
    params.str_wsc    = 0.5
    params.hybridWS   = true
    params.ele        = xi.element.FIRE
    params.skill      = xi.skill.GREAT_KATANA
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Tachi: Jinpu
m:addOverride('xi.actions.weaponskills.tachi_jinpu.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits    = 2
    params.ftpMod     = { 0.5, 0.75, 1.0 }
    params.str_wsc    = 0.3
    params.hybridWS   = true
    params.ele        = xi.element.WIND
    params.skill      = xi.skill.GREAT_KATANA
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Tachi: Koki
m:addOverride('xi.actions.weaponskills.tachi_koki.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod     = { 0.5, 0.75, 1.0 }
    params.str_wsc    = 0.5
    params.mnd_wsc    = 0.3
    params.hybridWS   = true
    params.ele        = xi.element.LIGHT
    params.skill      = xi.skill.GREAT_KATANA
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Tachi: Yukikaze
m:addOverride('xi.actions.weaponskills.tachi_yukikaze.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params     = {}
    params.numHits   = 1
    params.ftpMod    = { 1.75, 2.0, 2.5 }
    params.str_wsc   = 0.75
    params.atkVaries = { 2.0, 2.0, 2.0 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.BLINDNESS
    local actionElement = xi.element.DARK
    local power         = 25
    local duration      = math.floor(60 * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-- Tachi: Gekko
m:addOverride('xi.actions.weaponskills.tachi_gekko.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params     = {}
    params.numHits   = 1
    params.ftpMod    = { 1.75, 2.00, 2.5 }
    params.str_wsc   = 0.75
    params.atkVaries = { 2, 2, 2 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.SILENCE
    local actionElement = xi.element.WIND
    local power         = 1
    local duration      = math.floor(60 * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-- Tachi: Kasha
m:addOverride('xi.actions.weaponskills.tachi_kasha.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits   = 1
    params.ftpMod    = { 1.75, 2.00, 2.5 }
    params.str_wsc   = 0.75
    params.atkVaries = { 1.65, 1.65, 1.65 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.PARALYSIS
    local actionElement = xi.element.ICE
    local power         = 25
    local duration      = math.floor(60 * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-- Tachi: Kaiten
m:addOverride('xi.actions.weaponskills.tachi_kaiten.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 3.0, 3.0, 3.0 }
    params.str_wsc = 0.6

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.RELIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Tachi: Rana
m:addOverride('xi.actions.weaponskills.tachi_rana.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 3
    params.ftpMod  = { 1.0, 1.0, 1.0 }
    params.str_wsc = 0.35
    params.acc100 = 1.0 params.acc200 = 1.25 params.acc300 = 1.5 -- TODO: verify -- "Accuracy varies with TP" in retail. All current evidence points to that this modifier is static values, not percentages.

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

return m
