-----------------------------------
-- func: reloadinteractions
-- desc: Reloads the interaction framework
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 5,
    parameters = 'b'
}

commandObj.onTrigger = function(player, shouldReloadData)
    local filesToUnload =
    {
        'scripts/globals/interaction/interaction_lookup',
        'scripts/globals/interaction/interaction_global',
    }

    for i = 1, #filesToUnload do
        package.loaded[filesToUnload[i]] = nil
    end

    require('scripts/globals/interaction/interaction_global')
    InteractionGlobal.reload(shouldReloadData)
    player:printToPlayer('Interaction framework was reloaded')
end

return commandObj
