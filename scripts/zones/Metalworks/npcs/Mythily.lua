-----------------------------------
-- Area: Metalworks
--  NPC: Mythily
-- Type: Immigration NPC
-- !pos 94 -20 -8 237
-----------------------------------
require("scripts/globals/conquest")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local new_nation = tpz.nation.BASTOK
    local old_nation = player:getNation()
    local rank = getNationRank(new_nation)

    if (old_nation == new_nation) then
        player:startEvent(362, 0, 0, 0, old_nation)
    elseif (player:getCurrentMission(old_nation) ~= tpz.mission.id.nation.NONE or player:getCharVar("MissionStatus") ~= 0) then
        player:startEvent(361, 0, 0, 0, new_nation)
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

        player:startEvent(360, 0, 1, player:getRank(), new_nation, has_gil, cost)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 360 and option == 1) then
        local new_nation = tpz.nation.BASTOK
        local rank = getNationRank(new_nation)
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
