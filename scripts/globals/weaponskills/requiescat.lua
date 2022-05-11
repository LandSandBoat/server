-----------------------------------
-- Requiescat
-- Sword weapon skill
-- Skill level: MERIT
-- Delivers a five-hit attack. Attack power varies with TP.
-- Element: None
-- Modifiers: MND:73~85%
-- 100%TP    200%TP    300%TP
--         ALL 1.0
-----------------------------------
require("scripts/globals/status")
require("scripts/settings/main")
require("scripts/globals/weaponskills")
-----------------------------------
local weaponskill_object = {}

weaponskill_object.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    -- check to see if player has the unlock charvar for this, if not, do no damage.
    local hasMeritWsUnlock = 1
	
    if player:isPC() then
	    hasMeritWsUnlock = player:getCharVar("hasRequiescatUnlock")
	end

    if hasMeritWsUnlock ~= 1 then
        player:PrintToPlayer("You don't have this WS unlocked.")
        return
    end

    local params = {}
    params.numHits = 5

    params.ftp100 = 2
    params.ftp200 = 4
    params.ftp300 = 6

    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0 + (player:getMerit(xi.merit.REQUIESCAT) * 0.17)
    params.chr_wsc = 0.0

    params.canCrit = false
    params.crit100 = 0.0
    params.crit200 = 0.0
    params.crit300 = 0.0

    params.acc100 = 0.0
    params.acc200 = 0.0
    params.acc300 = 0.0

    params.atk100 = 0.8
    params.atk200 = 0.9
    params.atk300 = 1.0

    params.formless = true

    if xi.settings.USE_ADOULIN_WEAPON_SKILL_CHANGES == true then
        params.mnd_wsc = 0.7 + (player:getMerit(xi.merit.REQUIESCAT) * 0.03)
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskill_object
