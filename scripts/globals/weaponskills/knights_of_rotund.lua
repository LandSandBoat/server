-----------------------------------
-- Knights Of Rotund
-- Joke Sword Weapon Skill granted by ExcalipoorII
-- Stat mods unknown
-----------------------------------
require("scripts/globals/weaponskills")
require("scripts/globals/status")
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftp100 = 3 params.ftp200 = 3 params.ftp300 = 3
    params.str_wsc = 0.0 params.dex_wsc = 0.0
    params.vit_wsc = 0.0 params.agi_wsc = 0.0
    params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    params.atk100 = 1 params.atk200 = 1 params.atk300 = 1

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
