-----------------------------------
-- Area: Western Adoulin
--  NPC: Kongramm
-- !pos 61 32 138 256
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getCurrentMission(xi.mission.log_id.SOA) == xi.mission.id.soa.A_CURSE_FROM_THE_PAST and
        not player:hasKeyItem(xi.ki.PIECE_OF_A_STONE_WALL)
    then
        if player:getCharVar('SOA_ACFTP_Kongramm') < 1 then
            -- Gives hint for SOA Mission: 'A Curse From the Past'
            player:startEvent(148)
        else
            -- Reminds player of hint for SOA Mission: 'A Curse From the Past'
            player:startEvent(149)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 148 then
        -- Gave hint for SOA Mission: 'A Curse From the Past'
        player:setCharVar('SOA_ACFTP_Kongramm', 1)
    end
end

return entity
