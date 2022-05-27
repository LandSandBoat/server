---------------------------------------------------------------------------------------------------
-- func: letmego
-- desc: removes most debilitating effects
---------------------------------------------------------------------------------------------------
require("scripts/globals/status")

cmdprops =
{
    permission = 2,
    parameters = ""
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!letmego")
end

function onTrigger(player)
    player:delStatusEffect(tpz.effect.TERROR)
    player:delStatusEffect(tpz.effect.SLEEP_I)
    player:delStatusEffect(tpz.effect.SLEEP_II)
    player:delStatusEffect(tpz.effect.LULLABY)
    player:delStatusEffect(tpz.effect.BIND)
    player:delStatusEffect(tpz.effect.WEIGHT)
    player:delStatusEffect(tpz.effect.PETRIFICATION)
    player:delStatusEffect(tpz.effect.STUN)
    player:delStatusEffect(tpz.effect.SILENCE)
    player:delStatusEffect(tpz.effect.WEAKNESS)
    player:delStatusEffect(tpz.effect.PARALYSIS)
    player:delStatusEffect(tpz.effect.BLINDNESS)
    player:delStatusEffect(tpz.effect.ELEGY)
    player:delStatusEffect(tpz.effect.SLOW)
    player:delStatusEffect(tpz.effect.BIO)
    player:delStatusEffect(tpz.effect.DIA)
    player:delStatusEffect(tpz.effect.AMNESIA)
    player:delStatusEffect(tpz.effect.CHARM_I)
    player:delStatusEffect(tpz.effect.CHARM_II)
    player:delStatusEffect(tpz.effect.POISON)
    player:delStatusEffect(tpz.effect.ACCURACY_DOWN)
    player:delStatusEffect(tpz.effect.ATTACK_DOWN)
    player:delStatusEffect(tpz.effect.EVASION_DOWN)
    player:delStatusEffect(tpz.effect.DEFENSE_DOWN)
end
