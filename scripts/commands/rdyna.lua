-----------------------------------
-- func: rdyna (Reset Dynamis)
-- desc: Resets variables related to Dynamis
-- If single it will just clear a single player's reservation variables.
-- If party or alliance it will clear all player's reservation variables as well as the zone's token.
-- NOTICE: Players need to be in the correct staging zone for their dynamis.
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "ss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!rdyna <single/party/alliance> <target>")
end

function onTrigger(player, aoe, target)
    local targ = nil
    local cursor_target = player:getCursorTarget()

    if aoe == nil then
        error(player, "You must specify if you want to reset vars for a single player, a party, or an alliance.")
    end

    if target then
        targ = GetPlayerByName(target)
        if not targ then
            error(player, string.format( "Player named '%s' not found!", target ) )
            return
        end
    elseif cursor_target and not cursor_target:isNPC() then
        targ = cursor_target
    else
        targ = player
    end

    local playersinparty = targ:getParty()
    local playersinally = targ:getAlliance()
    local dynaZone = xi.dynamis.dynaInfoEra[targ:getZoneID()].dynaZone
    local zone = GetZone(dynaZone)

    if aoe == "party" then
        for _, playerEntity in pairs(playersinparty) do
            playerEntity:setCharVar("DynaReservationStart", 73)
            player:PrintToPlayer(string.format("%s's variable has been reset.", playerEntity:getName()))
        end
        if dynaZone ~= nil then
            player:PrintToPlayer(string.format("NOTICE: Resetting dynamis token for zone %s", dynaZone))
            SetServerVariable(string.format("[DYNA]Token_%s", dynaZone), 0)
            xi.dynamis.cleanupDynamis(zone)
        end
        player:PrintToPlayer("NOTICE: Players must wait at minimum 5 minutes to re-enter dynamis so it can cleanup.")
    elseif aoe == "alliance" then
        for _, playerEntity in pairs(playersinally) do
            playerEntity:setCharVar("DynaReservationStart", 73)
            player:PrintToPlayer(string.format("%s's variable has been reset.", playerEntity:getName()))
        end
        if dynaZone ~= nil then
            player:PrintToPlayer(string.format("NOTICE: Resetting dynamis token for zone %s", dynaZone))
            SetServerVariable(string.format("[DYNA]Token_%s", dynaZone), 0)
            xi.dynamis.cleanupDynamis(zone)
        end
        player:PrintToPlayer("NOTICE: Players must wait at minimum 5 minutes to re-enter dynamis so it can cleanup.")
    else
        targ:setCharVar("DynaReservationStart", 73)
        player:PrintToPlayer(string.format("%s's variable has been reset.", targ:getName()))
    end

end
