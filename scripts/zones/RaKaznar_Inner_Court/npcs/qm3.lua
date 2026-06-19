-----------------------------------
-- Area: RaKaznar_Inner_Court
--  NPC: ??? (Spawns Wayward Bhoot and Dolorous Cyhiraeth)
-- !pos -199 -449 -200 276
-- ID 17908260
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local waywardBhoot      = GetMobByID(zones[xi.zone.RAKAZNAR_INNER_COURT].mob.WAYWARD_BHOOT)
    local dolorousCyhiraeth = GetMobByID(zones[xi.zone.RAKAZNAR_INNER_COURT].mob.DOLOROUS_CYHIRAETH)

    if not waywardBhoot or not dolorousCyhiraeth then
        return
    end

    if player:hasKeyItem(xi.ki.DAWN_PHANTOM_GEM) then
        if
            waywardBhoot:isSpawned() or
            dolorousCyhiraeth:isSpawned()
        then
            player:printToPlayer('Mobs are up already', xi.msg.channel.NS_SAY)
        else
            player:printToPlayer('Prepare yourself!', xi.msg.channel.NS_SAY)
            SpawnMob(waywardBhoot:getID()):updateClaim(player)
            SpawnMob(dolorousCyhiraeth:getID()):updateClaim(player)
            player:delKeyItem(xi.ki.DAWN_PHANTOM_GEM)
        end
    else
        player:printToPlayer('You sense a powerful presence, but lack the means to call it forth.', xi.msg.channel.NS_SAY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
