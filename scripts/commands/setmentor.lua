-----------------------------------
-- func: setmentor <MentorMode> <target>
-- desc: 0 = Not a mentor, 1 = Unlocked but inactive, 2 = Unlocked & flag on.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'is'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!setmentor <mode> (player)')
    player:PrintToPlayer('mode: 0 = Not a mentor, 1 = Unlocked but inactive.')
end

commandObj.onTrigger = function(player, mentorMode, target)
    -- validate mode
    if mentorMode == nil or mentorMode < 0 or mentorMode > 1 then
        error(player, 'Invalid mode.')
        return
    end

    -- validate target
    local targ
    if target == nil then
        targ = player
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format('Player named "%s" not found!', target))
            return
        end
    end

    -- set mentor mode (bool)
    targ:setMentor(mentorMode > 0)
end

return commandObj
