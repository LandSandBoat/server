-----------------------------------
-- Area: Upper Jeuno
--  NPC: Marble Bridge Eatery (Door)
-- !pos -96.6 -0.2 92.3 244
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

local doorCheck =
{
    xi.nation.SANDORIA,
    xi.nation.BASTOK,
    xi.nation.WINDURST,
    xi.job.WAR,
    xi.job.MNK,
    xi.job.WHM,
    xi.job.BLM,
    xi.job.RDM,
    xi.job.THF,
    xi.job.PLD,
    xi.job.DRK,
    xi.job.BST,
    xi.job.BRD,
    xi.job.RNG,
    xi.job.SAM,
    xi.job.NIN,
    xi.job.DRG,
    xi.job.SMN,
    xi.job.BLU,
    xi.job.COR,
    xi.job.PUP,
    xi.job.DNC,
    xi.job.SCH,
    xi.race.HUME_F,
    xi.race.ELVAAN_F,
    xi.race.TARU_F,
    xi.race.MITHRA,
    xi.race.GALKA,
    1,
    0,
}

local marbleEateryDoorCheck = function(player)
    local dayofthemonth = VanadielDayOfTheMonth()

    -- Rotation is based on https://ffxiclopedia.fandom.com/wiki/Marble_Bridge_Eatery removed by 3 days to match up with http://www.mithrapride.org/vana_time/
    for k, v in pairs(doorCheck) do
        if dayofthemonth == k then
            if (k >= 1 and k <= 3) then
                if player:getNation() == v then
                    player:startEvent(124, (dayofthemonth - 1), 1)
                else
                    player:startEvent(124, (dayofthemonth - 1), 0)
                end
            elseif (k >= 4 and k <= 23) then
                if player:getMainJob() == v then
                    player:startEvent(124, (dayofthemonth - 1), 1)
                else
                    player:startEvent(124, (dayofthemonth - 1), 0)
                end
            -- The second argument to startevent() becomes dayofthemonth + 1 instead of - 1 from here, so that we skip over the RUN and GEO events.
            elseif k == 24 and player:getRace() > 0 and player:getRace() <= v then
                player:startEvent(124, (dayofthemonth + 1), 1)
            elseif k == 25 and player:getRace() > doorCheck[k - 1] and player:getRace() <= v then
                player:startEvent(124, (dayofthemonth + 1), 1)
            elseif k == 26 and player:getRace() > doorCheck[k - 1] and player:getRace() <= v then
                player:startEvent(124, (dayofthemonth + 1), 1)
            elseif k == 27 and player:getRace() > doorCheck[k - 1] and player:getRace() <= v then
                player:startEvent(124, (dayofthemonth + 1), 1)
            elseif k == 28 and player:getRace() > doorCheck[k - 1] and player:getRace() <= v then
                player:startEvent(124, (dayofthemonth + 1), 1)
            elseif k == 29 and player:getGender() == v then
                player:startEvent(124, (dayofthemonth + 1), 1)
            elseif k == 30 and player:getGender() == v then
                player:startEvent(124, (dayofthemonth + 1), 1)
            else
                player:startEvent(124, (dayofthemonth + 1), 0)
            end
        end
    end
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    marbleEateryDoorCheck(player)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
