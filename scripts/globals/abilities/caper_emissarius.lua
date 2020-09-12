-----------------------------------
-- Ability: Caper Emissarius
-- Description Transfers enmity to a party member of your choice.
-- Obtained: SCH Level 96
-- Recast Time: 01:00:00
-- Duration: 00:00:30
-- target:transferEnmity(player, 99, 20.6)
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if (target == nil or target:getID() == player:getID() or not target:isPC()) then
        return tpz.msg.basic.CANNOT_ON_THAT_TARG, 0
    else
        return 0, 0
    end
end

function onUseAbility(player, target, ability)
    party:transferEnmity(player, 99, 20.6)
end