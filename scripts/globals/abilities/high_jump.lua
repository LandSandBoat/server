-----------------------------------
-- Ability: High Jump
-- Performs a high jumping attack on enemy.
-- Obtained: Dragoon Level 35
-- Recast Time: 2:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/weaponskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability, action)
    local params = {}
    params.numHits = 1
    local ftp = 1
    params.ftp100 = ftp params.ftp200 = ftp params.ftp300 = ftp
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    if (player:getMod(tpz.mod.FORCE_JUMP_CRIT) > 0) then
        params.crit100 = 1.0 params.crit200 = 1.0 params.crit300 = 1.0
    end
    params.canCrit = true
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1 params.atk200 = 1 params.atk300 = 1
    params.bonusTP = player:getMod(tpz.mod.JUMP_TP_BONUS)
    params.targetTPMult = 0
    params.hitsHigh = true

    if (target:isMob()) then
        local enmityShed = 50
        if player:getMainJob() ~= tpz.job.DRG then
            enmityShed = 30
        end
        target:lowerEnmity(player, enmityShed + player:getMod(tpz.mod.HIGH_JUMP_ENMITY_REDUCTION)) -- reduce total accumulated enmity
    end

    local taChar = player:getTrickAttackChar(target)

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, 0, params, 0, action, true, taChar)

    if (tpHits + extraHits > 0) then
        -- Under Spirit Surge, High Jump reduces TP of target
        if (player:hasStatusEffect(tpz.effect.SPIRIT_SURGE) == true) then
            target:delTP(damage * 0.2)
        end
        if (criticalHit) then
            action:speceffect(target:getID(), 38)
        end
        action:messageID(target:getID(), tpz.msg.basic.USES_JA_TAKE_DAMAGE)
        action:speceffect(target:getID(), 32)
    else
        action:messageID(target:getID(), tpz.msg.basic.JA_MISS_2)
        action:speceffect(target:getID(), 0)
    end

    return damage
end
