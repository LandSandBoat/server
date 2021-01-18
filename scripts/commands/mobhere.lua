-----------------------------------
-- func: mobhere <mobId>
-- desc: Spawns a MOB and then moves it to the current position, if in same zone.
--       Errors will despawn the MOB unless "noDepop" was specified (any value works).
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "is"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!mobhere {mobID} {noDepop}")
end

function onTrigger(player, mobId, noDepop)
    -- validate mobId
    local targ
    if (mobId == nil) then
        targ = player:getCursorTarget()
        if (targ == nil or not targ:isMob()) then
            error(player, "You must either provide a mobID or target a mob.")
            return
        end
    else
        targ = GetMobByID(mobId)
        if (targ == nil) then
            error(player, "Invalid mobID.")
            return
        end
    end
    mobId = targ:getID()

    -- attempt to bring mob here
    SpawnMob( mobId )
    if (player:getZoneID() == targ:getZoneID()) then
        targ:setPos( player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos(), player:getZoneID() )
    else
        if (noDepop == nil or noDepop == 0) then
            DespawnMob( mobId )
            player:PrintToPlayer("Despawned the mob because of an error.")
        end
        player:PrintToPlayer("Mob could not be moved to current pos - you are probably in the wrong zone.")
    end
end
