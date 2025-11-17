-----------------------------------
-- func: getprevzoneline
-- desc: gets the ID of the players last zoneline or cursor target.
-- Only works on players
-----------------------------------

---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = ''
}

commandObj.onTrigger = function(player)
    local target = player:getCursorTarget()

    if target and not target:isPC() then
            player:printToPlayer('Current target is not a Player, only Players have a previous zoneline IDs saved.')
            return
    elseif not target then
        target = player
    end

    local zoneline = player:getPreviousZoneLineID() or 0
    player:printToPlayer(string.format('Previous Zoneline ID: %u', zoneline))
end

return commandObj
