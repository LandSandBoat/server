-----------------------------------
-- Abyssea Sturdy Pyxis Red Chest
-----------------------------------
xi = xi or {}
xi.pyxis = xi.pyxis or {}

xi.pyxis.goldChest = {}

local function isEven(number)
    if number % 2 == 0 then
        return 0
    else
        return 1
    end
end

xi.pyxis.goldChest.startEvent = function(player, npc, event, contentMessage, timeleft)
    local targetnumber    = npc:getLocalVar('RAND_NUM')
    local maxUnlockNumber = npc:getLocalVar('MAX_UNLOCK_NUMBER')
    local currentAttempts = npc:getLocalVar('CURRENT_ATTEMPTS')
    local minNumber = 11
    local attemptsallowed = 5

    player:startEvent(event, contentMessage, minNumber, maxUnlockNumber, attemptsallowed, currentAttempts, targetnumber, 3, timeleft) -- Gold
end

xi.pyxis.goldChest.unlock = function(player, csid, option, npc)
    local ID              = zones[player:getZoneID()]
    local currentAttempts = npc:getLocalVar('CURRENT_ATTEMPTS')
    local attemptsallowed = 5
    local inputnumber     = bit.band(option, 0xFF)
    local targetnumber    = npc:getLocalVar('RAND_NUM')

    if inputnumber > 10 and inputnumber < 100 then
        local splitnumbers = {}

        for digit in string.gmatch(tostring(targetnumber), '%d') do
            table.insert(splitnumbers, digit)
        end

        currentAttempts = currentAttempts + 1
        npc:setLocalVar('CURRENT_ATTEMPTS', currentAttempts)

        if inputnumber == targetnumber then
            xi.pyxis.messageChest(player, ID.text.INPUT_SUCCESS_FAIL_GUESS, inputnumber, 1, 0, 0, npc) -- unlocking chest
            xi.pyxis.messageChest(player, ID.text.PLAYER_OPENED_LOCK, 0, 0, 0, 0, npc)
            xi.pyxis.openChest(player, npc)
        elseif currentAttempts >= attemptsallowed then
            xi.pyxis.removeChest(player, npc, 0, 1)
            xi.pyxis.messageChest(player, ID.text.PLAYER_FAILED_LOCK, 0, 0, 0, 0, npc)
            player:messageSpecial(ID.text.CHEST_DISAPPEARED)
        else
            xi.pyxis.messageChest(player, ID.text.INPUT_SUCCESS_FAIL_GUESS, inputnumber, 0, 0, 0, npc) -- nothing happens

            if inputnumber > targetnumber then
                player:messageSpecial(ID.text.GREATER_OR_LESS_THAN, inputnumber, 1, 0, 0) -- greater
            elseif inputnumber < targetnumber then
                player:messageSpecial(ID.text.GREATER_OR_LESS_THAN, inputnumber, 0, 0, 0) -- less
            end

            local randtext = math.random(1, 5)
            local randDigit = math.random(1, 2)

            local digit = tonumber(splitnumbers[randDigit])

            switch(randtext): caseof
            {
                [1] = function()
                    player:messageSpecial(ID.text.HUNCH_SECOND_FIRST_EVEN_ODD, randDigit - 1, isEven(digit), 0, 0)
                end,

                [2] = function()
                    player:messageSpecial(ID.text.HUNCH_SECOND_FIRST_IS, randDigit - 1, digit, 0, 0)
                end,

                [3] = function()
                    local hints = {}
                    if digit == 0 then
                        hints =
                        {
                            [1] = { min = digit,     mid = digit + 1, max = digit + 2 },
                        }
                    elseif digit == 1 then
                        hints =
                        {
                            [1] = { min = digit,     mid = digit + 1, max = digit + 2 },
                            [2] = { min = digit - 1, mid = digit,     max = digit + 1 },
                        }
                    elseif digit == 8 then
                        hints =
                        {
                            [1] = { min = digit - 1, mid = digit,     max = digit + 1 },
                            [2] = { min = digit - 2, mid = digit - 1, max = digit     },
                        }
                    elseif digit == 9 then
                        hints =
                        {
                            [1] = { min = digit - 2, mid = digit - 1, max = digit     },
                        }
                    else
                        hints =
                        {
                            [1] = { min = digit - 2, mid = digit - 1, max = digit     },
                            [2] = { min = digit - 1, mid = digit,     max = digit + 1 },
                            [3] = { min = digit,     mid = digit + 1, max = digit + 2 },
                        }
                    end

                    local rand = math.random(1, #hints)

                    local hintsRand = hints[rand]

                    player:messageSpecial(ID.text.HUNCH_SECOND_FIRST_IS_OR, randDigit - 1, hintsRand.min, hintsRand.mid, hintsRand.max)
                end,

                [4] = function()
                    player:messageSpecial(ID.text.HUNCH_ONE_DIGIT_IS, digit, 0, 0, 0)
                end,

                [5] = function()
                    local sum = tonumber(splitnumbers[1]) + tonumber(splitnumbers[2])
                    player:messageSpecial(ID.text.HUNCH_SUM_EQUALS, sum)
                end,
            }
        end
    end
end
