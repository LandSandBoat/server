-----------------------------------
-- func: test
-- desc: A test command module
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

local function double_print(player, str)
    print(str)
    player:PrintToPlayer(str, xi.msg.channel.SYSTEM_3, "")
end

function onTrigger(player)
    double_print("Test print")
end
