-----------------------------------
-- Area: RaKaznar_Inner_Court
--  NPC: ??? (Spawns Poxhound and Draftdance Fluturini)
-- !pos -179 -440 -140 276
-- ID 17908258
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local poxhound  = GetMobByID(zones[xi.zone.RAKAZNAR_INNER_COURT].mob.POXHOUND)
    local fluturini = GetMobByID(zones[xi.zone.RAKAZNAR_INNER_COURT].mob.DRAFTDANCE_FLUTURINI)

    if not poxhound or not fluturini then
        return
    end

    if player:hasKeyItem(xi.ki.DAWN_PHANTOM_GEM) then
        if
            poxhound:isSpawned() or
            fluturini:isSpawned()
        then
            player:printToPlayer('Mobs are up already', xi.msg.channel.NS_SAY)
        else
            player:printToPlayer('Prepare yourself!', xi.msg.channel.NS_SAY)
            SpawnMob(poxhound:getID()):updateClaim(player)
            SpawnMob(fluturini:getID()):updateClaim(player)
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
