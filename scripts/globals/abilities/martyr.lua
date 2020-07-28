-----------------------------------
-- Ability: Martyr
-- Sacrifices HP to heal a party member double the amount.
-- Obtained: White Mage Level 75
-- Recast Time: 0:10:00
-- Duration: Instant
-- Target: Party member, cannot target self.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if (player:getID() == target:getID()) then
        return tpz.msg.basic.CANNOT_PERFORM_TARG, 0
    elseif (player:getHP() < 4) then -- Fails if HP < 4
        return tpz.msg.basic.UNABLE_TO_USE_JA, 0
    else
        return 0, 0
    end
end

function onUseAbility(player, target, ability)
    -- Plus 5 percent hp recovers per extra martyr merit
    local meritBonus = player:getMerit(tpz.merit.MARTYR) - 5
    -- printf("Martyr Merit Bonus: %d", meritBonus)

    local hpPercent = (200 + meritBonus) / 100
    -- printf("Martyr HP Bonus Percent: %f", hpPercent)

    local damageHP = math.floor(player:getHP() * 0.25)
    -- printf("Martyr HP Damage: %d", damageHP)

    --We need to capture this here because the base damage is the basis for the heal
    local healHP = damageHP * hpPercent
    healHP = utils.clamp(healHP, 0, target:getMaxHP() - target:getHP())

    -- If stoneskin is present, it should absorb damage...
    damageHP = utils.stoneskin(player, damageHP)
    -- printf("Martyr Final HP Damage (After Stoneskin): %d", damageHP)

    -- Log HP Headed for Debug
    -- printf("Martyr Healed HP: %d", healHP)

    damageHP = utils.stoneskin(player, damageHP)
    player:takeDamage(damageHP)
    target:addHP(healHP)

    return healHP
end
