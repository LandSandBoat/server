-----------------------------------
-- func: afkcheck
-- desc: Sends a custom menu to the cursor target,
--     : with some very simple but randomized questions.
--     : If the target doesn't respond with a correct answer
--     : within 30 seconds, they will be set to 0hp.
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/utils")
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

function onTrigger(player)
    -- Validate target
    local target = player:getCursorTarget()

    if not target then
        player:PrintToPlayer("No target selected target, using self")
        target = player
    end

    if target:getObjType() ~= xi.objType.PC then
        player:PrintToPlayer("Invalid target")
    end

    -- Generate options
    local function getCorrectOption()
        local a = math.random(1, 10)
        local b = math.random(1, 10)
        local c = a + b

        return
        {
            string.format("%2i + %2i = %2i", a, b, c),
            function(playerArg)
                playerArg:PrintToPlayer("AFK Check passed", xi.msg.channel.NS_SAY)
                playerArg:setLocalVar("CAPTCHA", 0)
            end,
        }
    end

    local function getIncorrectOption()
        local a = math.random(1, 10)
        local b = math.random(1, 10)
        local randomChange = math.random(1, 3)
        if math.random(0, 1) == 1 then
            randomChange = randomChange * -1
        end

        local c = a + b + randomChange

        return
        {
            string.format("%2i + %2i = %2i", a, b, c),
            function(playerArg)
                playerArg:PrintToPlayer("AFK Check failed", xi.msg.channel.NS_SAY)
                playerArg:setHP(0)
            end,
        }
    end

    local options = {}
    table.insert(options, getCorrectOption())
    table.insert(options, getIncorrectOption())
    table.insert(options, getIncorrectOption())

    options = utils.shuffle(options)

    -- Present menu
    local menu =
    {
        title = "AFK Check: Please pick true statement (30s)",
        onStart = function(playerArg)
            playerArg:setLocalVar("CAPTCHA", 1)
        end,

        options = options,
        onCancelled = function(playerArg)
            playerArg:PrintToPlayer("AFK Check failed!", xi.msg.channel.NS_SAY)
        end,
    }
    target:customMenu(menu)

    -- Add timer
    target:timer(30000, function(playerArg)
        if playerArg:getLocalVar("CAPTCHA") == 1 then
            playerArg:setHP(0)
        end
    end)
end
