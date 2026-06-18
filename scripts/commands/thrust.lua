-----------------------------------
-- func: !thrust
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = 's'
}

commandObj.onTrigger = function(player)
    if player:hasStatusEffect(xi.effect.COSTUME) then
        return
    end

    player:injectActionPacket(player:getID(), 5, 211, 0, 0, 0, 10, 1)
end

return commandObj
