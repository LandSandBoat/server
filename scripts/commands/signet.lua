---------------------------------------------------------------------------------------------------
-- func: signet
-- desc: 
---------------------------------------------------------------------------------------------------
require("scripts/globals/conquest")


cmdprops =
{
    permission = 0,
    parameters = ""
}

function onTrigger(player)

	player:addStatusEffect(xi.effect.SIGNET, 0, 0, 18000)
	player:PrintToPlayer( "Signet" )
	
	
	player:delStatusEffect(xi.effect.SANCTION)
    player:delStatusEffect(xi.effect.SIGIL)


end
