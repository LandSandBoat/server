-----------------------------------
-- func: addspell <spellID> <player>
-- desc: adds the ability to use a spell to the player
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'ss'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!addspell <spellID/spellName> (player)')
end

commandObj.onTrigger = function(player, spellParam, target)
    local spellId = tonumber(spellParam) or xi.magic.spell[string.upper(spellParam)]

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
    targ:addSpell(spellId)
    player:printToPlayer(string.format('Added spell %i to %s.', spellId, targ:getName()))
end

return commandObj
