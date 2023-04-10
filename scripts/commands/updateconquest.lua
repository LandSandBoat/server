-----------------------------------
-- func: updateconquest
-- desc: Updates all conquest guard. (Need modify in db first.)
-----------------------------------

require("scripts/globals/conquest")

cmdprops =
{
    permission = 1,
    parameters = "i"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!updateconquest <type>")
    player:PrintToPlayer("Type: 0 = Conquest_Tally_Start, 1 = Conquest_Tally_End, 2 = Conquest_Update")
end

function onTrigger(player, updatetype)
    if updatetype == nil or updatetype < 0 or updatetype > 2 then
        error(player, "Invalid update type.")
        return
    end

    WeekUpdateConquest(updatetype)
end
