-----------------------------------
-- Sonic Thrust
-- Polearm weapon skill
-- Skill Level: 300
-- Delivers an area attack. Damage varies with TP.
-- Will stack with Sneak Attack.
-- Element: None
-- Modifiers: STR:40%  DEX:40%
-- 100%TP    200%TP    300%TP
-- 3.00       3.7       4.50
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onWeaponSkillSetup = function()
    return
    {
        requirements =
        {
            skill = xi.skill.POLEARM,
            level = 300,
            jobs  = { xi.job.DRG, xi.job.WAR, xi.job.PLD },
        },
        animation    = 132,
        skillchain   =
        {
            primary   = xi.skillchainType.TRANSFIXION,
            secondary = xi.skillchainType.SCISSION,
        },
        range        = 3,
        target       = { xi.target.HOSTILE },
        aoe          =
        {
            affects = { xi.target.HOSTILE },
            cone    =
            {
                origin   = xi.aoe.cone.FRONT,
                angle    = 45,
                distance = 10,
            },
        },
    }
end

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 3.0, 3.25, 3.5 }
    params.str_wsc = 0.3 params.dex_wsc = 0.3

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 3.0, 3.7, 4.5 }
        params.str_wsc = 0.4 params.dex_wsc = 0.4
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
