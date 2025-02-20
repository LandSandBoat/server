-----------------------------------
-- Area: Metalworks
--  NPC: Mythily
-- Type: Immigration NPC
-- !pos 94 -20 -8 237
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local newNation = xi.nation.BASTOK
    local oldNation = player:getNation()
    local rank = GetNationRank(newNation)

    if oldNation == newNation then
        player:startEvent(362, 0, 0, 0, oldNation)
    elseif
        player:getCurrentMission(oldNation) ~= xi.mission.id.nation.NONE or
        player:getMissionStatus(player:getNation()) ~= 0
    then
        player:startEvent(361, 0, 0, 0, newNation)
    elseif oldNation ~= newNation then
        local hasGil = 0
        local cost = 0

        if rank == 1 then
            cost = 40000
        elseif rank == 2 then
            cost = 12000
        elseif rank == 3 then
            cost = 4000
        end

        if player:getGil() >= cost then
            hasGil = 1
        end

        player:startEvent(360, 0, 1, player:getRank(newNation), newNation, hasGil, cost)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 360 and option == 1 then
        local newNation = xi.nation.BASTOK
        local rank = GetNationRank(newNation)
        local cost = 0

        if rank == 1 then
            cost = 40000
        elseif rank == 2 then
            cost = 12000
        elseif rank == 3 then
            cost = 4000
        end

        player:setNation(newNation)
        player:setGil(player:getGil() - cost)
        player:setRankPoints(0)
    end
end

return entity
