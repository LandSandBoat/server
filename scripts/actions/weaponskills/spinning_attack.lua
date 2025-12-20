-----------------------------------
-- Spinning Attack
-- Hand-to-Hand weapon skill
-- Skill Level: 150
-- Delivers an area attack. Radius varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Flame Gorget & Thunder Gorget.
-- Aligned with the Flame Belt & Thunder Belt.
-- Element: None
-- Modifiers: STR: 35%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onWeaponSkillSetup = function()
    return
    {
        requirements =
        {
            skill = xi.skill.HAND_TO_HAND,
            level = 150,
        },
        animation    = 21,
        skillchain   =
        {
            primary   = xi.skillchainType.LIQUEFACTION,
            secondary = xi.skillchainType.IMPACTION,
        },
        range        = 3,
        target       = { xi.target.HOSTILE },
        aoe          =
        {
            affects = { xi.target.HOSTILE },
            sphere  =
            {
                origin = xi.aoe.sphere.TARGET,
                radius = 4,
            },
        },
    }
end

-- TODO: Radius 5y at 2334 TP
weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.0, 1.0, 1.0 }
    params.str_wsc = 0.35

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 1.0 -- http://wiki.ffo.jp/html/2421.html
        params.multiHitfTP = true
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
