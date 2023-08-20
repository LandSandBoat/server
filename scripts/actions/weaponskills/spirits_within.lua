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
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local attack =
    {
        ['type'] = xi.attackType.BREATH,
        ['slot'] = xi.slot.MAIN,
        ['weaponType'] = player:getWeaponSkillType(xi.slot.MAIN),
        ['damageType'] = xi.damageType.ELEMENTAL
    }
    local calcParams =
    {
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

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        -- Damage calculations changed based on: http://www.bg-wiki.com/bg/Spirits_Within http://www.bluegartr.com/threads/121610-Rehauled-Weapon-Skills-tier-lists?p=6142188&viewfull=1#post6142188
        if tp == 3000 then
            wsc = playerHP
        elseif tp >= 2000 then
            wsc = math.floor(playerHP * .5)
        elseif tp >= 1000 then
            wsc = math.floor(playerHP * .125)
        end
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

    damage = xi.weaponskills.takeWeaponskillDamage(target, player, {}, primary, attack, calcParams, action)

    return calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.criticalHit, damage
end

return weaponskillObject
