-----------------------------------
-- Ability: Footwork
-- Makes kicks your primary mode of attack.
-- Obtained: Monk Level 65
-- Recast Time: 5:00
-- Duration: 1:00
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    local kickDmg = 20 + player:getWeaponDmg()
    local kickAttPercent = 25 + player:getMod(tpz.mod.FOOTWORK_ATT_BONUS)
    player:addStatusEffect(tpz.effect.FOOTWORK, kickDmg, 0, 60, 0, kickAttPercent)
end

return ability_object
