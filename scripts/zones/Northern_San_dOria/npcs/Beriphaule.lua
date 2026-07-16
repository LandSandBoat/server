-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Beriphaule
-- Type: Allegiance Changer NPC
-- !pos -247.422 7.000 28.992 231
-----------------------------------
---@type TNpcEntity
local entity = {}

local newCharCutsceneLocations =
{
    [1] = { x =    0, y =  0, z =  -12, rot = 192, zone = xi.zone.NORTHERN_SAN_DORIA },
    [2] = { x = -100, y = -8, z = -125, rot = 224, zone = xi.zone.PORT_SAN_DORIA     },
    [3] = { x = -100, y =  1, z =  -40, rot = 224, zone = xi.zone.SOUTHERN_SAN_DORIA },
}

entity.onTrigger = function(player, npc)
    local newNation = xi.nation.SANDORIA
    local oldNation = player:getNation()
    local rank = GetNationRank(newNation)

    if oldNation == newNation then
        player:startEvent(608, 0, 0, 0, oldNation)
    elseif
        player:getCurrentMission(oldNation) ~= xi.mission.id.nation.NONE or
        player:getMissionStatus(player:getNation()) ~= 0
    then
        player:startEvent(607, 0, 0, 0, newNation)
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

        local wasCitizen = utils.mask.getBit(player:getCharVar('HQuest[newCharacterCS]nations'), newNation) and 1 or 0
        player:startEvent(606, 0, wasCitizen, player:getRank(newNation), newNation, hasGil, cost)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 606 and option == 1 then
        local newNation = xi.nation.SANDORIA
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

        -- Remove Expeditionary Force insignias
        xi.expeditionaryForce.disposeInsigniaNationSwap(player)

        -- Handle New Character Cutscene
        local nationsSeen = player:getCharVar('HQuest[newCharacterCS]nations')
        if utils.mask.getBit(nationsSeen, newNation) then
            return
        end

        player:setCharVar('HQuest[newCharacterCS]notSeen', 1)
        local loc = newCharCutsceneLocations[math.randomInt(1, 3)]
        player:setPos(loc.x, loc.y, loc.z, loc.rot, loc.zone)
    end
end

return entity
