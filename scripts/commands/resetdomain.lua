-----------------------------------
-- func: resetdomain
-- desc: Resets, probably, Domain Invasion
-----------------------------------
cmdprops =
{
    permission = 3,
    parameters = ""
}

function onTrigger(player)
    if player:getLocalVar("DIResetWarning") == 0 then
        player:PrintToPlayer("WARNING: Before using, wait 5 mins. Then make ABSOLUTELY sure no domain NM is spawned.")
        player:PrintToPlayer("If you have already done this, execute the command again.")

        player:setLocalVar("DIResetWarning", 1)
    else
        local nextNM = GetServerVariable("[Domain]NM")
        
        -- Failsafe
        if nextNM > 3 then
            nextNM = 0
        end
        
        SetServerVariable("[Domain]NMSpawned", 0)
        SetServerVariable("[Domain]Notification", 0)
        SetServerVariable("[Domain]NM", nextNM)
        SetServerVariable("[Domain]NMToD", os.time() + 30)

        player:PrintToPlayer(string.format("Wait 30 seconds. Domain NM number %s should spawn.", nextNM))
        player:PrintToPlayer("0: Amphisbaena")
        player:PrintToPlayer("1: Tortuga")
        player:PrintToPlayer("2: Battosai")
        player:PrintToPlayer("3: Bahamut")

        player:setLocalVar("DIResetWarning", 0)
    end
end
