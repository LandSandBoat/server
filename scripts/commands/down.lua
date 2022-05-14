-----------------------------------
-- func: down <optional number> <optional target>
-- desc: Alters vertical coordinate
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "is"
}

function onTrigger(player, number, target)
    local cursor = player:getCursorTarget()

    if target == nil and cursor == nil then
        entity = player
    elseif target == nil and cursor ~= nil then
        entity = cursor
    elseif target ~= nil and GetPlayerByName(target) == nil then
        player:PrintToPlayer(string.format("Player named '%s' not found!", target))
        return
    else
        entity = GetPlayerByName(target)
    end

    local pos = entity:getPos()
    local adjustYposBy = 0

    if number ~= nil and number > 0 then
        adjustYposBy = pos.y +number
    else
        adjustYposBy = pos.y +0.5
    end

    entity:setPos(pos.x, adjustYposBy, pos.z, pos.rot)
end
