-----------------------------------
-- Area: RaKaznar_Inner_Court
--  NPC: ??? (Spawns Whitenoise Bats)
-- !pos 811 89 60 276
-- ID 17908259
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local whitenoiseBats = GetMobByID(zones[xi.zone.RAKAZNAR_INNER_COURT].mob.WHITENOISE_BATS)

    if not whitenoiseBats then
        return
    end

    if player:hasKeyItem(xi.ki.DAWN_PHANTOM_GEM) then
        if whitenoiseBats:isSpawned() then
            player:printToPlayer('Mob is up already', xi.msg.channel.NS_SAY)
        else
            player:printToPlayer('Prepare yourself!', xi.msg.channel.NS_SAY)
            SpawnMob(whitenoiseBats:getID()):updateClaim(player)
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
