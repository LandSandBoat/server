-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Beriphaule
-- Type: Allegiance Changer NPC
-- !pos -247.422 7.000 28.992 231
-----------------------------------
require("scripts/globals/conquest")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local new_nation = xi.nation.SANDORIA
    local old_nation = player:getNation()
    local rank = GetNationRank(new_nation)

    if (old_nation == new_nation) then
        player:startEvent(608, 0, 0, 0, old_nation)
    elseif (player:getCurrentMission(old_nation) ~= xi.mission.id.nation.NONE or player:getMissionStatus(player:getNation()) ~= 0) then
        player:startEvent(607, 0, 0, 0, new_nation)
    elseif (old_nation ~= new_nation) then
        local has_gil = 0
        local cost = 0

        if (rank == 1) then
            cost = 40000
        elseif (rank == 2) then
            cost = 12000
        elseif (rank == 3) then
            cost = 4000
        end

        if (player:getGil() >= cost) then
            has_gil = 1
        end

        player:startEvent(606, 0, 1, player:getRank(new_nation), new_nation, has_gil, cost)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 606 and option == 1) then
        local new_nation = xi.nation.SANDORIA
        local rank = GetNationRank(new_nation)
        local cost = 0

        if (rank == 1) then
            cost = 40000
        elseif (rank == 2) then
            cost = 12000
        elseif (rank == 3) then
            cost = 4000
        end

        player:setNation(new_nation)
        player:setGil(player:getGil() - cost)
        player:setRankPoints(0)
    end

end

return entity
