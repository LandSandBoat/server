-----------------------------------
-- Ability: Gauge
-- Checks to see if an enemy can be charmed.
-- Obtained: Beastmaster Level 10
-- Recast Time: 0:30
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if (player:getPet() ~= nil ) then
        return tpz.msg.basic.ALREADY_HAS_A_PET, 0
    else
        return 0, 0
    end
end

function onUseAbility(player, target, ability)

    local charmChance = player:getCharmChance(target, false)

    if (charmChance >= 75) then
        ability:setMsg(tpz.msg.basic.SHOULD_BE_ABLE_CHARM)  -- The <player> should be able to charm <target>.
    elseif (charmChance >= 50) then
        ability:setMsg(tpz.msg.basic.MIGHT_BE_ABLE_CHARM)   -- The <player> might be able to charm <target>.
    elseif (charmChance >= 25) then
        ability:setMsg(tpz.msg.basic.DIFFICULT_TO_CHARM)    -- It would be difficult for the <player> to charm <target>.
    elseif (charmChance >= 1) then
        ability:setMsg(tpz.msg.basic.VERY_DIFFICULT_CHARM)  -- It would be very difficult for the <player> to charm <target>.
    else
        ability:setMsg(tpz.msg.basic.CANNOT_CHARM)          -- The <player> cannot charm <target>!
    end

end
