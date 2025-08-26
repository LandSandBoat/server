---------------------------------------------------------------------------------------------------
-- func: bazaar
-- auth: Run_Away
-- desc: Teleports a player to the Bazaar zone (222).
---------------------------------------------------------------------------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = "s"
}

commandObj.onTrigger = function(player)

    if (player:getAnimation() == 44) then
        player:printToPlayer('You cannot do that while crafting. Cheater.')
        return
    end

    local zone = player:getZone():getID()
    local prevZone = player:getPreviousZone()

    if zone == 230 or zone == 50 or zone == 53 or zone == 231 or zone == 232 or zone == 233 or zone == 234 or zone == 235 or zone == 236 or zone == 237 or zone == 238 or zone == 239 or zone == 240 or zone == 241 or zone == 242 or zone == 243 or zone == 244 or zone == 245 or zone == 246 or zone == 247 or zone == 48 then
        player:setPos(0, 0, 0, 0, 222)
    elseif zone == 222 and prevZone ~= nil then
        player:setPos(0, 0, 0, 0, prevZone)
    else
        player:printToPlayer( "I'm sorry, Dave. I'm afraid I can't do that." )
    end
end

return commandObj
