-----------------------------------
-- func: down <optional number> <optional target>
-- desc: Alters vertical coordinate
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "is"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!down <yalms> (target)")
end

function onTrigger(player, number, target)
    local entity = player
    local cursor = player:getCursorTarget()

    if target == nil and cursor == nil then
        player:PrintToPlayer("Moving self.. ")
    elseif target == nil and cursor ~= nil then
        entity = cursor
        player:PrintToPlayer("Moving cursor target.. ")
    elseif target ~= nil and GetPlayerByName(target) == nil then
        error(player, string.format("Player named '%s' not found!", target))
        return
    else
        entity = GetPlayerByName(target)
        player:PrintToPlayer("Moving specified player.. ")
    end

    local pos = entity:getPos()
    local adjustYposBy = 0

    if number ~= nil and number > 0 then
        adjustYposBy = pos.y + number
    else
        adjustYposBy = pos.y + 0.5
    end

    entity:setPos(pos.x, adjustYposBy, pos.z, pos.rot)
end
