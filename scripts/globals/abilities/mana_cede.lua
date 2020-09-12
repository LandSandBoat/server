-----------------------------------
-- Ability: Mana Cede
-- Description Channels your MP into TP for avatars and elementals.
-- Obtained: SMN Level 87
-- Recast Time: 00:05:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    target:addStatusEffect(tpz.effect.MANA_CEDE,15,1,1)
end