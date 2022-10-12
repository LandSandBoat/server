-----------------------------------
-- func: sanction
-- desc: Casts sanction on the player.
-----------------------------------

cmdprops =
{
    permission = 0,
    parameters = "is"
}

function onTrigger(player)
    player:PrintToPlayer("Enjoy sanction!")
    player:delStatusEffectsByFlag(xi.effectFlag.INFLUENCE, true)
    player:addStatusEffect(xi.effect.SANCTION, 0, 0, 15000)
end