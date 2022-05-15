-----------------------------------
-- func: up
-- desc: Add 10 to the player's y position
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

function onTrigger(player)
    -- validate target
    local targ
    local cursorTarget = player:getCursorTarget()
    if cursorTarget and not cursorTarget:isNPC() then
        targ = cursorTarget
    else
        targ = player
    end

    targ:setPos(targ:getXPos(), targ:getYPos() - 10, targ:getZPos(), targ:getRotPos())
end
