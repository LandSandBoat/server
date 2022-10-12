-----------------------------------
-- func: signet
-- desc: Casts signet on the player.
-----------------------------------

cmdprops =
{
    permission = 0,
    parameters = "is"
}

function onTrigger(player)
    player:PrintToPlayer("Enjoy signet!")
    player:delStatusEffectsByFlag(xi.effectFlag.INFLUENCE, true)
    player:addStatusEffect(xi.effect.SIGNET, 0, 0, 15000)
end