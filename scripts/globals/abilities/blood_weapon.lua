-----------------------------------
-- Ability: Blood Weapon
-- Causes all attacks to drain enemy's HP.
-- Obtained: Dark Knight Level 1
-- Recast Time: 1:00:00
-- Duration: 0:00:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    local effect = tpz.effect.BLOOD_WEAPON
    doEnspell(player,target,nil,effect)
end
