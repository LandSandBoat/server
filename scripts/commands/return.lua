-----------------------------------
-- func: return <player>
-- desc: Warps GM or target player to their previous zone
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!return (player)")
end

function onTrigger(player, target)
    -- validate target
    local targ
    if target == nil then
        targ = player
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format("Player named '%s' not found!", target))
            return
        end
    end

    -- get previous zone
    local zoneId = targ:getPreviousZone()
    if
        zoneId == nil or
        zoneId == xi.zone.UNKNOWN or
        zoneId == xi.zone.RESIDENTIAL_AREA
    then
        error(player, "Previous zone was a Mog House or there was a problem fetching the ID.")
        return
    end

    -- zone target
    targ:setPos(0, 0, 0, 0, zoneId)
    if targ:getID() ~= player:getID() then
        player:PrintToPlayer(string.format("%s was returned to zone %i.", targ:getName(), zoneId))
    end
end
