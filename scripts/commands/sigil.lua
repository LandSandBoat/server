---------------------------------------------------------------------------------------------------
-- func: sigil
-- desc: 
---------------------------------------------------------------------------------------------------

require("scripts/globals/campaign")

cmdprops =
{
    permission = 0,
    parameters = ""
}

function onTrigger(player)

	player:addStatusEffect(xi.effect.SIGIL, 0, 0, 18000)
	player:PrintToPlayer( "Sigil" )
	player:delStatusEffect(xi.effect.SANCTION)
    player:delStatusEffect(xi.effect.SIGNET)
end
