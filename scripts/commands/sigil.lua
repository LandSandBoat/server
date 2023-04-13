-----------------------------------
-- func: sigil
-- desc: Casts sigil on the player.
-----------------------------------

cmdprops =
{
    permission = 0,
    parameters = "is"
}

function onTrigger(player)
    player:PrintToPlayer("Enjoy sigil!")
    player:delStatusEffectsByFlag(xi.effectFlag.INFLUENCE, true)
    player:addStatusEffect(xi.effect.SIGIL, 0, 0, 15000)
end