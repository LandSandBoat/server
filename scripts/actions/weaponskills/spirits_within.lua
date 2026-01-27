-----------------------------------
-- Spirits Within
-- Sword weapon skill
-- Spirits Within Sword Weapon Skill
-- TrolandAdded by Troland
-- Skill Level: 175
-- Delivers an unavoidable attack. Damage varies with HP and TP.
-- Not aligned with any "elemental gorgets" or "elemental belts" due to it's absence of Skillchain properties.
-- Element: None
-- Modifiers: HP:
-- 100%TP    200%TP    300%TP
-- 12.5%       50%      100%
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod  = { 0.0625, 0.1875, 0.46875 } -- https://www.bg-wiki.com/index.php?title=Spirits_Within&oldid=269806

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
    local dmg = 0

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod  = { 0.125, 0.5, 1 } -- https://www.bg-wiki.com/ffxi/Spirits_Within
    end

    local ftp = xi.weaponskills.fTP(tp, params.ftpMod)
    dmg = math.floor(playerHP * ftp)

    local damage = dmg
    damage = math.floor(damage * xi.combat.damage.calculateDamageAdjustment(target, false, false, false, true))
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
end

return weaponskillObject
