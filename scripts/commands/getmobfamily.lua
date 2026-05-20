-----------------------------------
-- func: getmobfamily <optional MobID>
-- desc: Prints the mob's super family ID.
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
    player:printToPlayer('!getmobfamily (mob ID)')
end

local function getSuperFamilyName(id)
    for name, value in pairs(xi.mobSuperFamily) do
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

    local familyId = targ:getSuperFamily()
    player:printToPlayer(string.format('%s %i mob family is %i (%s).', targ:getName(), targ:getID(), familyId, getSuperFamilyName(familyId)))
end

return commandObj
