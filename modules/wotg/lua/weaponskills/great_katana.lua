-----------------------------------
-- Date : 2007-11-19 (One day prior to WoTG release)
-----------------------------------
require('modules/module_utils')
-----------------------------------

local m = Module:new('toau_great_katana')

-----------------------------------
-- Tachi: Enpi
-----------------------------------
m:addOverride('xi.actions.weaponskills.tachi_enpi.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 2
    params.ftpMod  = { 1.00, 1.50, 2.00 }
    params.str_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Tachi: Hobaku
-----------------------------------
m:addOverride('xi.actions.weaponskills.tachi_hobaku.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 1.00, 1.00, 1.00 }
    params.str_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.STUN
    local actionElement = xi.element.THUNDER
    local skillType     = xi.skill.GREAT_KATANA
    local resist        = xi.combat.magicHitRate.calculateResistRate(player, target, 0, skillType, 0, actionElement, 0, effectId, 0)
    if math.random(1, 100) <= tp / 30 * resist then
        local power         = 1
        local duration      = 3
        xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)
    end

    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Tachi: Goten
-----------------------------------
m:addOverride('xi.actions.weaponskills.tachi_goten.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.numHits    = 1
    params.ftpMod     = { 0.50, 0.75, 1.00 }
    params.str_wsc    = 0.3
    params.hybridWS   = true
    params.ele        = xi.element.THUNDER
    params.skill      = xi.skill.GREAT_KATANA
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Tachi: Kagero
-----------------------------------
m:addOverride('xi.actions.weaponskills.tachi_kagero.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.numHits    = 1
    params.ftpMod     = { 0.50, 0.75, 1.00 }
    params.str_wsc    = 0.5
    params.hybridWS   = true
    params.ele        = xi.element.FIRE
    params.skill      = xi.skill.GREAT_KATANA
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Tachi: Jinpu
-----------------------------------
m:addOverride('xi.actions.weaponskills.tachi_jinpu.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits    = 2
    params.ftpMod     = { 0.50, 0.75, 1.00 }
    params.str_wsc    = 0.3
    params.hybridWS   = true
    params.ele        = xi.element.WIND
    params.skill      = xi.skill.GREAT_KATANA
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Tachi: Koki
-----------------------------------
m:addOverride('xi.actions.weaponskills.tachi_koki.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.numHits    = 1
    params.ftpMod     = { 0.50, 0.75, 1.00 }
    params.str_wsc    = 0.5
    params.mnd_wsc    = 0.3
    params.hybridWS   = true
    params.ele        = xi.element.LIGHT
    params.skill      = xi.skill.GREAT_KATANA
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Tachi: Yukikaze
-----------------------------------
m:addOverride('xi.actions.weaponskills.tachi_yukikaze.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params     = {}
    params.numHits   = 1
    params.ftpMod    = { 1.75, 2.00, 2.50 }
    params.str_wsc   = 0.75
    params.atkVaries = { 1.50, 1.50, 1.50 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.BLINDNESS
    local actionElement = xi.element.DARK
    local power         = 25
    local skillType     = xi.skill.GREAT_KATANA
    local resist        = xi.combat.magicHitRate.calculateResistRate(player, target, 0, skillType, 0, actionElement, 0, effectId, 0)
    local duration      = math.floor(60 * resist)
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Tachi: Gekko
-----------------------------------
m:addOverride('xi.actions.weaponskills.tachi_gekko.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params     = {}
    params.numHits   = 1
    params.ftpMod    = { 1.75, 2.00, 2.50 }
    params.str_wsc   = 0.75
    params.atkVaries = { 2.00, 2.00, 2.00 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.SILENCE
    local actionElement = xi.element.WIND
    local power         = 1
    local skillType     = xi.skill.GREAT_KATANA
    local resist        = xi.combat.magicHitRate.calculateResistRate(player, target, 0, skillType, 0, actionElement, 0, effectId, 0)
    local duration      = math.floor(60 * resist)
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Tachi: Kasha
-----------------------------------
m:addOverride('xi.actions.weaponskills.tachi_kasha.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params     = {}
    params.numHits   = 1
    params.ftpMod    = { 1.75, 2.00, 2.50 }
    params.str_wsc   = 0.75
    params.atkVaries = { 1.65, 1.65, 1.65 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.PARALYSIS
    local actionElement = xi.element.ICE
    local power         = 25
    local skillType     = xi.skill.GREAT_KATANA
    local resist        = xi.combat.magicHitRate.calculateResistRate(player, target, 0, skillType, 0, actionElement, 0, effectId, 0)
    local duration      = math.floor(60 * resist)
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Tachi: Kaiten
-----------------------------------
m:addOverride('xi.actions.weaponskills.tachi_kaiten.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 3.00, 3.00, 3.00 }
    params.str_wsc = 0.6

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.RELIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Tachi: Rana
-----------------------------------
m:addOverride('xi.actions.weaponskills.tachi_rana.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params     = {}
    params.numHits   = 3
    params.ftpMod    = { 1.00, 1.00, 1.00 }
    params.str_wsc   = 0.35
    params.accVaries = { 0, 30, 60 } -- TODO: verify exact number

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

return m
