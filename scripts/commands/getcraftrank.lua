-----------------------------------
-- func: getcraftRank <craft skill or ID> (player)
-- desc: returns target's RANK of specified craft skill
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'ss'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!getcraftRank <craft skill or ID> (player)')
end

commandObj.onTrigger = function(player, craftName, target)
    if craftName == nil then
        error(player, 'You must specify a craft skill to check!')
        return
    end

    local skillID = tonumber(craftName) or xi.skill[string.upper(craftName)]
    local targ = nil

    if skillID == nil or skillID < 48 or skillID > 57 then
        error(player, 'You must specify a valid craft skill.')
        return
    end

    if target == nil then
        if player:getCursorTarget() == nil then
            targ = player
        else
            if player:getCursorTarget():isPC() then
                targ = player:getCursorTarget()
            else
                error(player, 'You must target a player or specify a name.')
                return
            end
        end
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            player:PrintToPlayer(string.format('Player named "%s" not found!', target))
            return
        end
    end

    player:PrintToPlayer(string.format('%s\'s current skillID \'%s\' rank: %u', targ:getName(), craftName, targ:getSkillRank(skillID)))
end

return commandObj
