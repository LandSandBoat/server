-----------------------------------
-- func: down <optional number> <optional target>
-- desc: Alters vertical coordinate
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'is'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!down <yalms> (target)')
end

commandObj.onTrigger = function(player, number, target)
    ---@type CBaseEntity?
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

    if entity then
        local pos = entity:getPos()
        local adjustYposBy = 0

        if number ~= nil and number > 0 then
            adjustYposBy = pos.y + number
        else
            adjustYposBy = pos.y + 0.5
        end

        entity:setPos(pos.x, adjustYposBy, pos.z, pos.rot)
    end
end

return commandObj
