-----------------------------------
-- func: skipcs
-- desc: Functions the same as `!release`, but also sends the packet that
--       triggers the onEventFinish logic for a cutscene.
--       If no arguments are given, option will default to 0.
--       You can optionally pass in the option for the cs.
--   ex: !skipcs 1000
--     : Calls: onEventFinish(player, csid, option, npc)
--     : csid: the cs you're in, option: 1000
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!skipcs (option)")
end

function onTrigger(player, option)
    local target = nil

    local cursorTarget = player:getCursorTarget()
    if cursorTarget then
        target = cursorTarget
    else
        target = player
    end

    target:skipEvent(option)

    -- NOTE: Since sending a release packet out-of-line can get the client's camera stuck in the middle
    --     : of the cutscene, we force a zone to the same spot to reset the camera's position.
    target:setPos(target:getXPos(), target:getYPos(), target:getZPos(), target:getRotPos(), target:getZoneID())
end
