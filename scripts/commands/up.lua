-----------------------------------
-- func: up <optional number> <optional target>
-- desc: Alters vertical coordinate
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'is'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!up <yalms> (target)')
end

commandObj.onTrigger = function(player, number, target)
    local entity = player
    local cursor = player:getCursorTarget()

    if target == nil and cursor == nil then
        player:printToPlayer('Moving self.. ')
    elseif target == nil and cursor ~= nil then
        entity = cursor
        player:printToPlayer('Moving cursor target.. ')
    elseif target ~= nil and GetPlayerByName(target) == nil then
        error(player, string.format('Player named "%s" not found!', target))
        return
    else
        entity = GetPlayerByName(target)
        player:printToPlayer('Moving specified player.. ')
    end

    local pos = entity:getPos()
    local adjustYposBy = 0

    if number ~= nil and number > 0 then
        adjustYposBy = pos.y -number
    else
        adjustYposBy = pos.y -0.5
    end

    entity:setPos(pos.x, adjustYposBy, pos.z, pos.rot)
end

return commandObj
