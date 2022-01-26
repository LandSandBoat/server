---------------------------------------------------------------------------------------------------
-- func: Sanction
-- desc: 
---------------------------------------------------------------------------------------------------
require("scripts/globals/besieged")


cmdprops =
{
    permission = 0,
    parameters = ""
}

function onTrigger(player)

	player:addStatusEffect(xi.effect.SANCTION, 0, 0, 18000)
	player:PrintToPlayer( "Sanction" )
	player:delStatusEffect(xi.effect.SIGNET)
    player:delStatusEffect(xi.effect.SIGIL)
end
