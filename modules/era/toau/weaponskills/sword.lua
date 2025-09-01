-----------------------------------
-- ToAU era sword weaponskill module
-- Sets fTP, WSC and additional effects to their ToAU values
-- Target date: 2007-11-19 (one day prior to WotG release)
-----------------------------------
require('modules/module_utils')
-----------------------------------

local m = Module:new('toau_weaponskills_sword')

-- Fast Blade
m:addOverride('xi.actions.weaponskills.fast_blade.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 3
    params.ftpMod  = { 1.0, 1.5, 2.0 }
    params.str_wsc = 0.2
    params.dex_wsc = 0.2

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Burning Blade
m:addOverride('xi.actions.weaponskills.burning_blade.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod     = { 1.0, 2.0, 2.5 }
    params.str_wsc    = 0.2
    params.int_wsc    = 0.2
    params.ele        = xi.element.FIRE
    params.skill      = xi.skill.SWORD
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-- Red Lotus Blade
m:addOverride('xi.actions.weaponskills.red_lotus_blade.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod     = { 1.0, 2.375, 3.0 }
    params.str_wsc    = 0.3
    params.int_wsc    = 0.2
    params.ele        = xi.element.FIRE
    params.skill      = xi.skill.SWORD
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-- Flat Blade
m:addOverride('xi.actions.weaponskills.flat_blade.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 1, 1, 1 }
    params.str_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    if math.random(1, 100) <= tp / 30 * applyResistanceAddEffect(player, target, xi.element.THUNDER, 0) then
        local effectId      = xi.effect.STUN
        local actionElement = xi.element.THUNDER
        local power         = 1
        local duration      = math.floor(4 * applyResistanceAddEffect(player, target, actionElement, 0))
        xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)
    end

    return tpHits, extraHits, criticalHit, damage
end)

-- Shining Blade
m:addOverride('xi.actions.weaponskills.shining_blade.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits    = 1
    params.ftpMod     = { 1.0, 2.0, 2.5 }
    params.str_wsc    = 0.2
    params.mnd_wsc    = 0.2
    params.ele        = xi.element.LIGHT
    params.skill      = xi.skill.SWORD
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-- Seraph Blade
m:addOverride('xi.actions.weaponskills.seraph_blade.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod     = { 1.0, 2.5, 3.0 }
    params.str_wsc    = 0.3
    params.mnd_wsc    = 0.3
    params.ele        = xi.element.LIGHT
    params.skill      = xi.skill.SWORD
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-- Circle Blade
m:addOverride('xi.actions.weaponskills.circle_blade.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 1.0, 1.0, 1.0 }
    params.str_wsc = 0.35

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Spirits Within
m:addOverride('xi.actions.weaponskills.spirits_within.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local attack =
    {
        ['type'] = xi.attackType.BREATH,
        ['slot'] = xi.slot.MAIN,
        ['weaponType'] = player:getWeaponSkillType(xi.slot.MAIN),
        ['damageType'] = xi.damageType.ELEMENTAL
    }
    local calcParams =
    {
        wsID = wsID, -- need 'calcParams.wsID' passed to global
        criticalHit = false,
        tpHitsLanded = 0,
        extraHitsLanded = 0,
        shadowsAbsorbed = 0,
        bonusTP = 0
    }

    local playerHP = player:getHP()
    local wsc = 0
    -- Damage calculations based on https://www.bg-wiki.com/index.php?title=Spirits_Within&oldid=269806
    if tp == 3000 then
        wsc = math.floor(playerHP * 120 / 256)
    elseif tp >= 2000 then
        wsc = math.floor(playerHP * (math.floor(0.072 * tp) - 96) / 256)
    elseif tp >= 1000 then
        wsc = math.floor(playerHP * (math.floor(0.016 * tp) + 16) / 256)
    end

    local damage = target:breathDmgTaken(wsc)
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

-- Vorpal Blade
m:addOverride('xi.actions.weaponskills.vorpal_blade.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits    = 4
    params.ftpMod     = { 1.0, 1.0, 1.0 }
    params.str_wsc    = 0.3
    params.critVaries = { 0.1, 0.3, 0.5 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Swift Blade
m:addOverride('xi.actions.weaponskills.swift_blade.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 3
    params.ftpMod  = { 1.5, 1.5, 1.5 }
    params.str_wsc = 0.3
    params.mnd_wsc = 0.3
    -- Sufficient data for ACC bonus/penalty does not exist; assuming no penalty and 10% increase per 1000 TP
    -- http://wiki.ffo.jp/html/382.html does not list ACC Bonus
    -- https://www.bg-wiki.com/ffxi/Swift_Blade does not list ACC Bonus
    params.accVaries = { 1.0, 1.0, 1.0 } -- TODO: verify -- "Accuracy varies with TP" in retail. All current evidence points to that this modifier is static values, not percentages.

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Savage Blade
m:addOverride('xi.actions.weaponskills.savage_blade.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod  = { 1.0, 1.75, 3.5 }
    params.str_wsc = 0.3
    params.mnd_wsc = 0.5

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Knights of Round
m:addOverride('xi.actions.weaponskills.knights_of_round.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 3.0, 3.0, 3.0 }
    params.str_wsc = 0.4
    params.mnd_wsc = 0.4

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.RELIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Atonement
m:addOverride('xi.actions.weaponskills.atonement.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits    = 2
    params.ftpMod     = { 1, 1.25, 1.5 }
    params.str_wsc    = 0.4
    params.vit_wsc    = 0.5
    params.enmityMult = 1

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

    -- Calculate damage caps (item level and level based)
    local levelUsed       = player:getAverageItemLevel() > 99 and player:getAverageItemLevel() or player:getMainLvl()
    -- local hitDamageCap    = (levelUsed + 14) * 5 -- iLvl 119 -> 665
    local globalDamageCap = levelUsed * 10       -- iLvl 119 -> 1190

    -- If the target isn't a mob,theres no enmity to calculate with.
    if target:getObjType() ~= xi.objType.MOB then
        params.ftpMod = { 1, 1.5, 2 }

        damage, calcParams.criticalHit, calcParams.tpHitsLanded, calcParams.extraHitsLanded = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
        return calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.criticalHit, damage
    end

    -- Regular
    local dmg = (target:getCE(player) + target:getVE(player)) / 6
    -- tp affects enmity multiplier, 1.0 at 1k, 1.5 at 2k, 2.0 at 3k. Gorget/Belt adds 100 tp each.
    params.enmityMult = params.enmityMult + (tp + xi.combat.physical.calculateFTPBonus(player) * 1000 - 1000) / 2000
    params.enmityMult = utils.clamp(params.enmityMult, 1, 2) -- necessary because of Gorget/Belt bonus

    damage = target:breathDmgTaken(dmg)
    if player:getMod(xi.mod.WEAPONSKILL_DAMAGE_BASE + wsID) > 0 then
        damage = damage * (100 + player:getMod(xi.mod.WEAPONSKILL_DAMAGE_BASE + wsID)) / 100
    end

    damage = utils.clamp(damage, 0, globalDamageCap)
    calcParams.finalDmg = damage

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

    return calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.criticalHit, damage
end)

-- Death Blossom
m:addOverride('xi.actions.weaponskills.death_blossom.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 3
    params.ftpMod  = { 1.125, 1.125, 1.125 }
    params.str_wsc = 0.3
    params.mnd_wsc = 0.5

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- TODO: Death Blossom should be chance to apply effect. Need testing

    -- Handle status effect
    local effectId = xi.effect.MAGIC_EVASION_DOWN
    local power    = 10
    local duration = 60
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, 0, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-- Expiacion
m:addOverride('xi.actions.weaponskills.expiacion.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod = { 1.5, 2.0, 2.5 }
    params.str_wsc = 0.3
    params.int_wsc = 0.3

    -- Apply Aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

return m
