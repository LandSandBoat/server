-----------------------------------
-- Ability: Fan Dance
-- Reduces physical damage taken and increases enmity but renders Samba unusable. Physical damage reduction gradually decreases with each hit taken.
-- Obtained: Dancer Level 75 Merit Group 2
-- Recast Time: 3 minutes
-- Duration: 5 minutes
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
   return 0, 0
end

function onUseAbility(player, target, ability)
    player:addStatusEffect(tpz.effect.FAN_DANCE, 90, 0, 300)
end
