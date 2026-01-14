-----------------------------------
-- Date : 2007-11-19 (One day prior to WoTG release)
-----------------------------------
require('modules/module_utils')
-----------------------------------

local m = Module:new('toau_sword')

-----------------------------------
-- Fast Blade
-----------------------------------
m:addOverride('xi.actions.weaponskills.fast_blade.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 2
    params.ftpMod  = { 1.00, 1.50, 2.00 }
    params.str_wsc = 0.2
    params.dex_wsc = 0.2

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Burning Blade
-----------------------------------
m:addOverride('xi.actions.weaponskills.burning_blade.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.ftpMod     = { 1.00, 2.00, 2.50 }
    params.str_wsc    = 0.2
    params.int_wsc    = 0.2
    params.ele        = xi.element.FIRE
    params.skill      = xi.skill.SWORD
    params.includemab = true
    params.dStat      = xi.mod.INT

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Red Lotus Blade
-----------------------------------
m:addOverride('xi.actions.weaponskills.red_lotus_blade.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.ftpMod     = { 1.00, 2.375, 3.00 }
    params.str_wsc    = 0.3
    params.int_wsc    = 0.2
    params.ele        = xi.element.FIRE
    params.skill      = xi.skill.SWORD
    params.includemab = true
    params.dStat      = xi.mod.INT

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Flat Blade
-----------------------------------
m:addOverride('xi.actions.weaponskills.flat_blade.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 1.00, 1.00, 1.00 }
    params.str_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.STUN
    local actionElement = xi.element.THUNDER
    local skillType     = xi.skill.SWORD
    local skillRank     = player:getSkillRank(skillType)
    local resist        = xi.combat.magicHitRate.calculateResistRate(player, target, 0, skillType, skillRank, actionElement, 0, effectId, 0)
    if math.random(1, 100) <= tp / 30 * resist then
        local power         = 1
        local duration      = math.floor(4 * resist)
        xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)
    end

    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Shining Blade
-----------------------------------
m:addOverride('xi.actions.weaponskills.shining_blade.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits    = 1
    params.ftpMod     = { 1.00, 2.00, 2.50 }
    params.str_wsc    = 0.2
    params.mnd_wsc    = 0.2
    params.ele        = xi.element.LIGHT
    params.skill      = xi.skill.SWORD
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Seraph Blade
-----------------------------------
m:addOverride('xi.actions.weaponskills.seraph_blade.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.ftpMod     = { 1.00, 2.50, 3.00 }
    params.str_wsc    = 0.3
    params.mnd_wsc    = 0.3
    params.ele        = xi.element.LIGHT
    params.skill      = xi.skill.SWORD
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Circle Blade
-----------------------------------
m:addOverride('xi.actions.weaponskills.circle_blade.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 1.00, 1.00, 1.00 }
    params.str_wsc = 0.35

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Spirits Within
-----------------------------------
m:addOverride('xi.actions.weaponskills.spirits_within.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.ftpMod  = { 0.0625, 0.1875, 0.46875 }

    local attack =
    {
        ['type'] = xi.attackType.BREATH,
        ['slot'] = xi.slot.MAIN,
        ['weaponType'] = player:getWeaponSkillType(xi.slot.MAIN),
        ['damageType'] = xi.damageType.ELEMENTAL
    }

    local calcParams =
    {
        wsID = wsID,
        criticalHit = false,
        tpHitsLanded = 0,
        extraHitsLanded = 0,
        shadowsAbsorbed = 0,
        bonusTP = 0
    }

    local playerHP = player:getHP()
    local dmg = 0

    local ftp = xi.weaponskills.fTP(tp, params.ftpMod)
    dmg = math.floor(playerHP * ftp)

    local damage = dmg
    damage = math.floor(damage * xi.spells.damage.calculateDamageAdjustment(target, false, false, false, true))
    damage = math.floor(damage * xi.spells.damage.calculateAbsorption(target, xi.element.NONE, false))
    damage = math.floor(damage * xi.spells.damage.calculateNullification(target, xi.element.NONE, false, true))
    damage = math.floor(target:handleSevereDamage(damage, false))

    if damage > 0 then
        if player:getOffhandDmg() > 0 then
            calcParams.tpHitsLanded = 2
        else
            calcParams.tpHitsLanded = 1
        end
    end

    if player:getMod(xi.mod.WEAPONSKILL_DAMAGE_BASE + wsID) > 0 then
        damage = damage * (100 + player:getMod(xi.mod.WEAPONSKILL_DAMAGE_BASE + wsID)) / 100
    end

    damage = damage * xi.settings.main.WEAPON_SKILL_POWER
    calcParams.finalDmg = damage

    -- Todo: xi.weaponskills.doBreathWeaponskill() instead of all this.
    damage = xi.weaponskills.takeWeaponskillDamage(target, player, {}, primary, attack, calcParams, action)

    return calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.criticalHit, damage
end)

-----------------------------------
-- Vorpal Blade
-----------------------------------
m:addOverride('xi.actions.weaponskills.vorpal_blade.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.numHits    = 4
    params.ftpMod     = { 1.00, 1.00, 1.00 }
    params.str_wsc    = 0.3
    params.critVaries = { 0.10, 0.30, 0.50 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Swift Blade
-----------------------------------
m:addOverride('xi.actions.weaponskills.swift_blade.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params     = {}
    params.numHits   = 3
    params.ftpMod    = { 1.50, 1.50, 1.50 }
    params.str_wsc   = 0.3
    params.mnd_wsc   = 0.3
    params.accVaries = { 0, 30, 50 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Savage Blade
-----------------------------------
m:addOverride('xi.actions.weaponskills.savage_blade.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod  = { 1.00, 1.75, 3.50 }
    params.str_wsc = 0.3
    params.mnd_wsc = 0.5

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Knights of Round
-----------------------------------
m:addOverride('xi.actions.weaponskills.knights_of_round.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 3.00, 3.00, 3.00 }
    params.str_wsc = 0.4
    params.mnd_wsc = 0.4

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.RELIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Atonement
-----------------------------------
m:addOverride('xi.actions.weaponskills.atonement.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.numHits    = 2
    params.ftpMod     = { 1.00, 1.50, 2.00 } -- 1x Enmity @ 1000 TP, 1.5x Enmity @ 2000 TP, 2x Enmity @ 3000 TP
    params.enmityMult = utils.clamp(xi.weaponskills.fTP(tp, params.ftpMod), 1, 2) -- Enmity multiplier based on fTP, clamped between 1 and 2.
    -- 1000 TP: 9% CE + 11% VE, 2000 TP: 11% CE + 14% VE, 3000 TP: 20% CE + 25% VE
    local cePercent = xi.weaponskills.fTP(tp, { 0.09, 0.11, 0.20 })
    local vePercent = xi.weaponskills.fTP(tp, { 0.11, 0.14, 0.25 })

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local attack =
    {
        ['type'] = xi.attackType.BREATH,
        ['slot'] = xi.slot.MAIN,
        ['weaponType'] = player:getWeaponSkillType(xi.slot.MAIN),
        ['damageType'] = xi.damageType.ELEMENTAL
    }

    local calcParams =
    {
        wsID            = wsID,
        criticalHit     = false,
        tpHitsLanded    = 0,
        extraHitsLanded = 0,
        shadowsAbsorbed = 0,
        bonusTP         = 0
    }

    local damage = 0

    local levelUsed       = player:getMainLvl()
    local globalDamageCap = levelUsed * 10 -- 750 at level 75.

    -- If the target isn't a mob,theres no enmity to calculate with.
    if target:getObjType() ~= xi.objType.MOB then
        params.ftpMod = { 1.00, 1.50, 2.00 }

        damage, calcParams.criticalHit, calcParams.tpHitsLanded, calcParams.extraHitsLanded = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
        return calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.criticalHit, damage
    end

    -- Regular damage formula
    local dmg = target:getCE(player) * cePercent + target:getVE(player) * vePercent

    -- This is here to account for damage adjustments needed because it is breath damage.
    damage = dmg
    damage = math.floor(damage * xi.spells.damage.calculateDamageAdjustment(target, false, false, false, true))
    damage = math.floor(damage * xi.spells.damage.calculateAbsorption(target, xi.element.NONE, false))
    damage = math.floor(damage * xi.spells.damage.calculateNullification(target, xi.element.NONE, false, true))
    damage = math.floor(target:handleSevereDamage(damage, false))

    if player:getMod(xi.mod.WEAPONSKILL_DAMAGE_BASE + wsID) > 0 then
        damage = damage * (100 + player:getMod(xi.mod.WEAPONSKILL_DAMAGE_BASE + wsID)) / 100
    end

    damage = utils.clamp(damage, 0, globalDamageCap)
    calcParams.finalDmg = damage

    -- If one or more hits land, Atonement always counts as landing both hits.
    if damage > 0 then
        if player:getOffhandDmg() > 0 then
            calcParams.tpHitsLanded = 2
        else
            calcParams.tpHitsLanded = 1
        end

        -- Atonement always yields the a TP return of a 2 hit WS (unless it does 0 damage), because if one hit lands, both hits do.
        calcParams.extraHitsLanded = 1
    end

    damage = xi.weaponskills.takeWeaponskillDamage(target, player, params, primary, attack, calcParams, action)

    -- If Atonement deals 0 damage, it will print as 0 damage instead of a miss.
    if damage == 0 then
        action:resolution(target:getID(), xi.action.resolution.HIT)
        action:messageID(target:getID(), xi.msg.basic.DAMAGE)
    end

    return calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.criticalHit, damage
end)

-----------------------------------
-- Death Blossom
-----------------------------------
m:addOverride('xi.actions.weaponskills.death_blossom.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 3
    params.ftpMod  = { 1.125, 1.125, 1.125 }
    params.str_wsc = 0.3
    params.mnd_wsc = 0.5

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.MAGIC_EVASION_DOWN
    local actionElement = xi.element.THUNDER
    local power         = 10
    local skillType     = xi.skill.SWORD
    local skillRank     = player:getSkillRank(skillType)
    local resist        = xi.combat.magicHitRate.calculateResistRate(player, target, 0, skillType, skillRank, actionElement, 0, effectId, 0)
    local duration      = math.floor(60 * resist) -- TODO: Chance to apply varies with TP.
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Expiacion
-----------------------------------
m:addOverride('xi.actions.weaponskills.expiacion.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 2
    params.ftpMod  = { 1.50, 2.00, 2.50 }
    params.str_wsc = 0.3
    params.int_wsc = 0.3

    -- Apply Aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

return m
