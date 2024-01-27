-----------------------------------
-- func: !rename
-- desc: Renames target NPC or MOB. Limited to 16 character spaces.
--       Does not work on players. Does not alter database.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'si'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!rename (string) (optional npcID/mobID)')
end

commandObj.onTrigger = function(player, inputString, entityID)
    local entity = player:getCursorTarget()

    if entityID then
        entity = GetMobByID(entityID)
        if not entity then
            entity = GetNPCByID(entityID)
        end
    end

    if not entity then
        error(player, 'Entity not found')
        return
    end

    if inputString == '""' then
        entity:renameEntity('', true)
    else
        entity:renameEntity(inputString, true)
    end
end

return commandObj
