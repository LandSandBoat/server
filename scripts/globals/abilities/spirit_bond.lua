-----------------------------------
-- Ability: Spirit Bond
-- Description Enables the dragoon to take some damage on behalf of their wyvern. Using Healing Breath also restores the wyvern's HP.
-- Obtained: DRG Level 65
-- Recast Time: 00:03:00
-- Duration: 00:01:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    player:addStatusEffect(tpz.effect.SPIRIT_BOND,14,0,60)
end