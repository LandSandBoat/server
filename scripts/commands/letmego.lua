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
    player:delStatusEffect(xi.effect.TERROR)
    player:delStatusEffect(xi.effect.SLEEP_I)
    player:delStatusEffect(xi.effect.SLEEP_II)
    player:delStatusEffect(xi.effect.LULLABY)
    player:delStatusEffect(xi.effect.BIND)
    player:delStatusEffect(xi.effect.WEIGHT)
    player:delStatusEffect(xi.effect.PETRIFICATION)
    player:delStatusEffect(xi.effect.STUN)
    player:delStatusEffect(xi.effect.SILENCE)
    player:delStatusEffect(xi.effect.WEAKNESS)
    player:delStatusEffect(xi.effect.PARALYSIS)
    player:delStatusEffect(xi.effect.BLINDNESS)
    player:delStatusEffect(xi.effect.ELEGY)
    player:delStatusEffect(xi.effect.SLOW)
    player:delStatusEffect(xi.effect.BIO)
    player:delStatusEffect(xi.effect.DIA)
    player:delStatusEffect(xi.effect.AMNESIA)
    player:delStatusEffect(xi.effect.CHARM_I)
    player:delStatusEffect(xi.effect.CHARM_II)
    player:delStatusEffect(xi.effect.POISON)
    player:delStatusEffect(xi.effect.ACCURACY_DOWN)
    player:delStatusEffect(xi.effect.ATTACK_DOWN)
    player:delStatusEffect(xi.effect.EVASION_DOWN)
    player:delStatusEffect(xi.effect.DEFENSE_DOWN)
end
