-----------------------------------
-- Area: Heavens Tower
--  NPC: Rakano-Marukano
-- Type: Immigration NPC
-- !pos 6.174 -1 32.285 242
-----------------------------------
---@type TNpcEntity
local entity = {}

local newCharCutsceneLocations =
{
    [1] = { x = -140,     y = -7, z =  172,   rot =  32, zone = xi.zone.PORT_WINDURST   },
    [2] = { x =  -40.611, y = -5, z =  102.5, rot =  57, zone = xi.zone.WINDURST_WATERS },
    [3] = { x =   30,     y =  2, z =  -40,   rot = 128, zone = xi.zone.WINDURST_WOODS  },
}

entity.onTrigger = function(player, npc)
    local newNation = xi.nation.WINDURST
    local oldNation = player:getNation()
    local rank = GetNationRank(newNation)

    if oldNation == newNation then
        player:startEvent(10004, 0, 0, 0, oldNation)
    elseif
        player:getCurrentMission(oldNation) ~= xi.mission.id.nation.NONE or
        player:getMissionStatus(player:getNation()) ~= 0
    then
        player:startEvent(10003, 0, 0, 0, newNation)
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
        player:startEvent(10002, 0, wasCitizen, player:getRank(newNation), newNation, hasGil, cost)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10002 and option == 1 then
        local newNation = xi.nation.WINDURST
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
