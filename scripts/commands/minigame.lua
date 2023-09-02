-----------------------------------
-- func: minigame
-- desc: Opens a menu to allow you to quickly test minigames.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = ''
}

commandObj.onTrigger = function(player)
    local menu =
    {
        title = 'Minigame Test Menu',
        options =
        {
            {
                'Full Speed Ahead! (Normal)',
                function(playerArg)
                    playerArg:setCharVar('[QUEST]FullSpeedAhead', 1)
                    player:setPos(475, 8.8, -159, 128, xi.zone.BATALLIA_DOWNS)
                end,
            },
            {
                'Full Speed Ahead! (Easy)',
                function(playerArg)
                    playerArg:setCharVar('[QUEST]FullSpeedAhead', 2)
                    player:setPos(475, 8.8, -159, 128, xi.zone.BATALLIA_DOWNS)
                end,
            },
        },
    }
    player:customMenu(menu)
end

return commandObj
