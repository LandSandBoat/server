-----------------------------------
-- Atonement
-- TODO: This needs to be reworked, as this weapon skill does damage based on current enmity, not based on stat modifiers. http://wiki.ffxiclopedia.org/wiki/Atonement    http://www.bg-wiki.com/bg/Atonement
-- Sword weapon skill
-- Skill Level: N/A
-- Delivers a Twofold attack. Enmity varies with TP. Burtgang: Aftermath effect varies with TP.
-- Available only after completing the Unlocking a Myth (Paladin) quest.
-- Aligned with the Aqua Gorget, Flame Gorget & Light Gorget.
-- Aligned with the Aqua Belt, Flame Belt & Light Belt.
-- Element: None
-- Modifiers (old): damage varies with enmity
-- 100%TP    200%TP    300%TP
-- 0.09      0.11      0.20   -CE
-- 0.11      0.14      0.25   -VE
-- Modifiers (new): enmity from damage varies with TP
-- 100%TP    200%TP    300%TP
-- 1.00      1.5       2.0
-- Modifiers (non-mob, wrong): STR:40% VIT:50%
-- 100%TP    200%TP    300%TP
-- 1.00      1.25      1.50
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
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

    if damage == 0 then
        -- The logic above sets the action as a miss if CE/VE are 0 on the target
        -- because the landed hits are (correctly) set to 0
        -- Atonement is not known to miss and should always report as a hit.
        -- It is fairly unique in that regard, which is why it is handled as a special case here.
        action:resolution(target:getID(), xi.action.resolution.HIT)
        action:messageID(target:getID(), xi.msg.basic.DAMAGE)
    end

    return calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.criticalHit, damage
end

return weaponskillObject
