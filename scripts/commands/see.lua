-----------------------------------
-- func: see
-- desc: Informs the user if they can see the target
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

function onTrigger(player)
    local cursorTarget = player:getCursorTarget()
    if cursorTarget == nil then
        player:PrintToPlayer("No target selected")
        return
    end

    if player:canSee(cursorTarget) then
        player:PrintToPlayer(player:getName() .. " CAN SEE " .. cursorTarget:getName())
    else
        player:PrintToPlayer(player:getName() .. " CANNOT SEE " .. cursorTarget:getName())
    end
end
