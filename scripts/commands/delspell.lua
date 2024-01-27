-----------------------------------
-- func: delspell <spellID> <player>
-- desc: Removes a spell from the players spell list.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'is'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!delspell <spellID> (player)')
end

commandObj.onTrigger = function(player, spellId, target)
    -- validate spellId
    if spellId == nil then
        error(player, 'Invalid spellID.')
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

    -- add spell
    targ:delSpell(spellId)
    player:printToPlayer(string.format('Deleted spell %i from %s.', spellId, targ:getName()))
end

return commandObj
