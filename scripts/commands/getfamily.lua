-----------------------------------
-- func: getfamily <optional MobID>
-- desc: Prints the mob's family ID.
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'i'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!getfamily (mob ID)')
end

local function getFamilyName(id)
    for name, value in pairs(xi.mobFamily) do
        if value == id then
            return name
        end
    end

    return 'UNKNOWN'
end

commandObj.onTrigger = function(player, mobId)
    local targ
    if mobId == nil then
        targ = player:getCursorTarget()
        if not targ or not targ:isMob() then
            error(player, 'You must either provide a mob ID or target a mob with your cursor.')
            return
        end
    else
        targ = GetMobByID(mobId)
        if targ == nil then
            error(player, 'Invalid mob ID.')
            return
        end
    end

    local familyId = targ:getFamily()
    player:printToPlayer(string.format('%s %i mob family is %i (%s).', targ:getName(), targ:getID(), familyId, getFamilyName(familyId)))
end

return commandObj
