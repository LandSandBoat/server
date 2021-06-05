---------------------------------------------------------------------------------------------------
-- func: reloadinteractions
-- desc: Reloads the interaction framework
---------------------------------------------------------------------------------------------------
require("scripts/globals/interaction/interaction_global")

cmdprops =
{
    permission = 5,
    parameters = "b"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!reloadinteraction <reload-data>")
end

function onTrigger(player, shouldReloadData)
    local filesToUnload = {
        "scripts/globals/interaction/interaction_lookup",
        "scripts/globals/interaction/interaction_global",
    }

    for i=1, #filesToUnload do
        package.loaded[filesToUnload[i]] = nil
    end

    require("scripts/globals/interaction/interaction_global")
    InteractionGlobal.reload(shouldReloadData)
    player:PrintToPlayer("Interaction framework was reloaded")
end
