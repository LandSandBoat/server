-----------------------------------
-- Death Blossom
-- Sword weapon skill (RDM main only)
-- Description: Delivers a threefold attack that lowers target's magic evasion. Chance of lowering target's magic evasion varies with TP. Murgleis: Aftermath effect varies with TP.
-- Lowers magic evasion by up to 10.
-- Effect lasts up to 55 seconds.
-- Available only after completing the Unlocking a Myth (Red Mage) quest.
-- Aligned with the Breeze Gorget, Thunder Gorget, Aqua Gorget & Snow Gorget.
-- Aligned with the Breeze Belt, Thunder Belt, Aqua Belt & Snow Belt.
-- Modifiers: STR:30%  MND:50%
-- 100%TP     200%TP      300%TP
--  4              4           4        new
-- 1.125      1.125      1.125        old
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 3
    params.ftpMod  = { 1.125, 1.125, 1.125 }
    params.str_wsc = 0.3
    params.mnd_wsc = 0.5

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 4, 4, 4 }
    end

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId = xi.effect.MAGIC_EVASION_DOWN
    local power    = 10
    local duration = math.floor(tp / 50 - 5)
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, 0, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
