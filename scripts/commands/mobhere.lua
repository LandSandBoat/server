-----------------------------------
-- func: mobhere <mobId>
-- desc: Spawns a MOB and then moves it to the current position, if in same zone.
--       Errors will despawn the MOB unless "noDepop" was specified (any value works).
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "is"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!mobhere (mobID) (noDepop)")
end

function onTrigger(player, mobId, noDepop)
    local zone = player:getZone()
    if zone:getType() == xi.zoneType.INSTANCED then
        local instance = player:getInstance()
        local targ

        -- validate mobId
        if mobId == nil then
            targ = player:getCursorTarget()
            if targ == nil or not targ:isMob() then
                error(player, "You must either provide a mobID or target a mob.")
                return
            end
        else
            targ = GetMobByID(mobId, instance)
            if targ == nil then
                error(player, "Invalid mobID.")
                return
            end
        end

        if not targ:isSpawned() then
            SpawnMob(mobId, instance)
            player:PrintToPlayer("Mob state changed to: Spawned.")
        end

        targ:setPos(player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos())
    else
        -- validate mobId
        local targ
        if mobId == nil then
            targ = player:getCursorTarget()
            if targ == nil or not targ:isMob() then
                error(player, "You must either provide a mobID or target a mob.")
                return
            end
        else
            targ = GetMobByID(mobId)
            if targ == nil then
                error(player, "Invalid mobID.")
                return
            end
        end

        mobId = targ:getID()

        if not targ:isSpawned() then
            SpawnMob(mobId)
            player:PrintToPlayer("Mob state changed to: Spawned.")
        end

        if player:getZoneID() == targ:getZoneID() then
            targ:setPos(player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos(), player:getZoneID())
        else
            if noDepop == nil or noDepop == 0 then
                DespawnMob(mobId)
                player:PrintToPlayer("Despawned the mob because of an error.")
            end

            player:PrintToPlayer("Mob could not be moved to current pos - you are probably in the wrong zone.")
        end
    end
end
