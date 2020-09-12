-----------------------------------
-- Ability: Mana Wall
-- Description	Allows you to take damage with MP.
-- Obtained: BLM Level 76
-- Recast Time: 00:10:00
-- Duration: 00:05:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)
    player:addStatusEffect(tpz.effect.MANA_WALL,4,0,300)
end