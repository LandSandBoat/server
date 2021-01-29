-----------------------------------
-- Area: Quicksand Caves
--  NPC: Fountain of Kings
-- Involved in Mission: San d'Oria 8-1
-- !pos 567 18 -939 208
-----------------------------------
local ID = require("scripts/zones/Quicksand_Caves/IDs")
require("scripts/globals/missions")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Player is on San d'Oria mission 8-1 "Coming of Age":
    if player:getCurrentMission(SANDORIA) == xi.mission.id.sandoria.COMING_OF_AGE then
        local missionStatus = player:getMissionStatus(player:getNation())
        local mob1 = GetMobByID(ID.mob.VALOR):isSpawned()
        local mob2 = GetMobByID(ID.mob.HONOR):isSpawned()

        if missionStatus == 2 and not mob1 and not mob2 then
            SpawnMob(ID.mob.VALOR)
            SpawnMob(ID.mob.HONOR)
        elseif missionStatus == 3 and not mob1 and not mob2 and not player:hasKeyItem(xi.ki.DROPS_OF_AMNIO) then
            player:addKeyItem(xi.ki.DROPS_OF_AMNIO)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.DROPS_OF_AMNIO)
        end
    -- Default
    else
        player:messageSpecial(ID.text.POOL_OF_WATER)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
