---------------------------------------------------------------------------------------------------
-- func: costume
-- auth: <Unknown>
-- desc: Sets the players current costume.
---------------------------------------------------------------------------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = "i"
}

commandObj.onTrigger = function(player, costume)

	if (player:hasStatusEffect(xi.effect.DEDICATION) == true) then
        player:delStatusEffect(xi.effect.DEDICATION)
        player:printToPlayer("XP Buff removed")
    end

end

return commandObj
