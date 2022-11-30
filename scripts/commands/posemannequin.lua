-----------------------------------
-- func: posemannequin
-- desc: changes the pose of a mannequin
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/mannequins")
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "iis"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!posemannequin <race> <pose> [target])")
end

function onTrigger(player, race, pose, target)
    -- Get the target
    if target then
        target = GetPlayerByName(target)
    else
        target = player:getCursorTarget()
    end

    if not target or target:isNPC() then
        error(player, "No valid target found. place cursor on a non-npc object or specify a player name. ")
        return
    end

    -- Confirm race and pose parameters
    if not race or not pose then
        error(player, "Race and Pose not defined. ")
        return
    end

    if race > 0 then
        xi.mannequin.setMannequinPose(player, race, pose)
    end
end
