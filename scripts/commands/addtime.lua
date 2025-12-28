-----------------------------------
-- func: addtime
-- desc: Resets and then adds offset (in seconds) to earth clock.
--
-- Vana'Diel time is indirectly impacted by this command.
-- Use to adjust time to test timed conditions on quests and other.
--
-- Use with caution!
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 5,
    parameters = 'i'
}

local function error(player)
    player:printToPlayer('!addtime <offset_in_seconds>')
end

commandObj.onTrigger = function(player, offset)
    -- validate offset
    if offset == nil then
        error(player)
        return
    end

    SetTimeOffset(offset)
    -- Runs !time command to show the updated time.
    xi.commands.time.onTrigger(player)
end

return commandObj
