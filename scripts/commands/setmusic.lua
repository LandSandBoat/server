-----------------------------------
-- func: setmusic <typeID> <songID>
-- desc: Temporarily changes music played by users client
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'ii'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!setmusic <type ID> <song ID>')
    player:PrintToPlayer('type IDs: 0 = BGM (Day), 1 = BGM (Night), 2 = Solo-Battle, 3 = Party-Battle, 4 = Chocobo, 5=Death, 6=Moghouse, 7=Fishing')
end

commandObj.onTrigger = function(player, typeId, songId)
    -- validate typeId
    if typeId == nil or typeId < 0 or typeId > 7 then
        error(player, 'Invalid type ID.')
        return
    end

    -- validate songId
    if songId == nil or songId < 0 then
        error(player, 'Invalid song ID.')
        return
    end

    -- change music
    player:changeMusic(typeId, songId)
end

return commandObj
