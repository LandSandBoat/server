-----------------------------------
-- Ability: Devotion
-- Sacrifices HP to grant a party member the same amount in MP.
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
    -- Plus 5 percent mp recovers per extra devotion merit
    local meritBonus = player:getMerit(tpz.merit.DEVOTION) - 5
    -- printf("Devotion Merit Bonus: %d", meritBonus)

    local mpPercent = (25 + meritBonus) / 100
    -- printf("Devotion MP Percent: %f", mpPercent)

    local damageHP = math.floor(player:getHP() * 0.25)
    -- printf("Devotion HP Damage: %d", damageHP)

    -- If stoneskin is present, it should absorb damage...
    damageHP = utils.stoneskin(player, damageHP)
    -- printf("Devotion HP Damage (after Stoneskin): %d", damageHP)

    local healMP = player:getHP() * mpPercent
    healMP = utils.clamp(healMP, 0, target:getMaxMP() - target:getMP())
    -- printf("Devotion MP Healed: %d", healMP)

    damageHP = utils.stoneskin(player, damageHP)
    player:takeDamage(damageHP)
    target:addMP(healMP)

    return healMP
end
