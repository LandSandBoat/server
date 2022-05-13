-----------------------------------
-- func: elvorseal
-- desc: Casts elvorseal on the player.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "is"
}

function onTrigger(player)
    player:PrintToPlayer("Evlorseal applied")
    player:addStatusEffect(xi.effect.ELVORSEAL, 1, 0, 0)
end