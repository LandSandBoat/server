-----------------------------------
-- Abyssea Sturdy Pyxis Red Chest
-----------------------------------
xi = xi or {}
xi.pyxis = xi.pyxis or {}

xi.pyxis.blueChest = {}

xi.pyxis.blueChest.startEvent = function(player, npc, event, contentMessage, timeleft)
    local targetnumber    = npc:getLocalVar('RAND_NUM')
    local failedAttempts  = npc:getLocalVar('FAILED_ATTEMPTS')
    local currentAttempts = npc:getLocalVar('CURRENT_ATTEMPTS')
    local required        = npc:getLocalVar('REQUIRED')
    local attemptsallowed = 5

    player:startEvent(event, contentMessage, targetnumber, currentAttempts, required, failedAttempts, attemptsallowed, 3, timeleft)
end

xi.pyxis.blueChest.unlock = function(player, csid, option, npc)
    local ID               = zones[player:getZoneID()]
    local newRand          = math.random(10, 99)
    local lockedChoice     = bit.lshift(1, option - 1)
    local currentAttempts  = npc:getLocalVar('CURRENT_ATTEMPTS')
    local failedAttempts   = npc:getLocalVar('FAILED_ATTEMPTS')
    local requiredGuesses  = npc:getLocalVar('REQUIRED')
    local correctGuesses   = npc:getLocalVar('CORRECT_GUESSES')
    local lastrand         = npc:getLocalVar('RAND_NUM')
    local attemptsallowed  = 5

    if lockedChoice == 1 then
        npc:setLocalVar('RAND_NUM', newRand)

        if newRand > lastrand then -- check guesses
            xi.pyxis.messageChest(player, ID.text.RANDOM_SUCCESS_FAIL_GUESS, newRand, 0, 0, 0, npc)
            correctGuesses = correctGuesses + 1
            npc:setLocalVar('CORRECT_GUESSES', correctGuesses)

            if correctGuesses >= requiredGuesses then
                xi.pyxis.messageChest(player, ID.text.PLAYER_OPENED_LOCK, 0, 0, 0, 0, npc)
                xi.pyxis.openChest(player, npc)
            elseif correctGuesses < requiredGuesses then
                currentAttempts = currentAttempts + 1
                npc:setLocalVar('CURRENT_ATTEMPTS', currentAttempts)
            end
        else
            xi.pyxis.messageChest(player, ID.text.RANDOM_SUCCESS_FAIL_GUESS, newRand, 1, 0, 0, npc)
            failedAttempts = failedAttempts + 1
            npc:setLocalVar('FAILED_ATTEMPTS', failedAttempts)

            if failedAttempts >= attemptsallowed then
                xi.pyxis.removeChest(player, npc, 0, 1)
                xi.pyxis.messageChest(player, ID.text.PLAYER_FAILED_LOCK, 0, 0, 0, 0, npc)
                player:messageSpecial(ID.text.CHEST_DISAPPEARED)
            end
        end
    elseif lockedChoice == 2 then
        npc:setLocalVar('RAND_NUM', newRand)

        if newRand < lastrand then -- check guesses
            xi.pyxis.messageChest(player, ID.text.RANDOM_SUCCESS_FAIL_GUESS, newRand, 0, 0, 0, npc)
            correctGuesses = correctGuesses + 1
            npc:setLocalVar('CORRECT_GUESSES', correctGuesses)

            if correctGuesses >= requiredGuesses then
                xi.pyxis.messageChest(player, ID.text.PLAYER_OPENED_LOCK, 0, 0, 0, 0, npc)
                xi.pyxis.openChest(player, npc)
            elseif correctGuesses < requiredGuesses then
                if currentAttempts == nil then
                    npc:setLocalVar('CURRENT_ATTEMPTS', 1)
                else
                    currentAttempts = currentAttempts + 1
                    npc:setLocalVar('CURRENT_ATTEMPTS', currentAttempts)
                end
            end
        else
            xi.pyxis.messageChest(player, ID.text.RANDOM_SUCCESS_FAIL_GUESS, newRand, 1, 0, 0, npc)
            failedAttempts = failedAttempts + 1
            npc:setLocalVar('FAILED_ATTEMPTS', failedAttempts)

            if failedAttempts >= attemptsallowed then
                xi.pyxis.removeChest(player, npc, 0, 1)
                xi.pyxis.messageChest(player, ID.text.PLAYER_FAILED_LOCK, 0, 0, 0, 0, npc)
                player:messageSpecial(ID.text.CHEST_DISAPPEARED)
            end
        end
    end
end
