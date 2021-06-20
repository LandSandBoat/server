-----------------------------------
-- func: !instance <instance_id>
-- desc: Load an instance and take you there
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "i"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!instance <instance_id>")
end

function onTrigger(player, instance_id)
    local currentInstance = player:getInstance()
    if currentInstance then
        player:PrintToPlayer("It is not safe to use this command while inside an instance, try again after exiting.")
        currentInstance:fail()
    else
        player:createInstance(instance_id)
    end
end
