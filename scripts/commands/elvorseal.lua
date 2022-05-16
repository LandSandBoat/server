-----------------------------------
-- func: elvorseal
-- desc: Casts elvorseal on the player.
-----------------------------------

cmdprops =
{
    permission = 0,
    parameters = ""
}

function onTrigger(player)
    player:PrintToPlayer("Elvorseal has been applied")
    player:addStatusEffect(xi.effect.ELVORSEAL, 1, 0, 0)
end