-----------------------------------
-- func: getspecies <optional MobID>
-- desc: Prints the mob's species ID.
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
    player:printToPlayer('!getspecies (mob ID)')
end

local function getSpeciesName(id)
    for name, value in pairs(xi.mobSpecies) do
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

    local speciesId = targ:getSpecies()
    player:printToPlayer(string.format('%s %i mob species is %i (%s).', targ:getName(), targ:getID(), speciesId, getSpeciesName(speciesId)))
end

return commandObj
