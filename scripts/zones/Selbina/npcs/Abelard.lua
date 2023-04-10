-----------------------------------
-- Area: Selbina (248)
--  NPC: Abelard
--  An Explorer's Footsteps
-- !pos -52 -11 -13 248
-- This quest was changed to require a minimum amount of fame to combat RMTs POS-Hacking around to
-- quickly earn gil. However, as this is not a legitimate concern on private servers players may
-- complete this quest even with no fame.
-----------------------------------
local ID = require("scripts/zones/Selbina/IDs")
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

local zoneId =
{
    0x00001, 800,   -- West Ronfaure
    0x00002, 800,   -- East Ronfaure
    0x00004, 1000,  -- La Theine Plateau
    0x00008, 1000,  -- Valkurm Dunes
    0x00010, 1000,  -- Jugner Forest
    0x00020, 3000,  -- North Gustaberg
    0x00040, 800,   -- South Gustaberg
    0x00080, 1000,  -- Konschtat Highlands
    0x00100, 1000,  -- Pashhow Marshlands
    0x00200, 3000,  -- Rolanberry Fields
    0x00400, 800,   -- West Sarutabaruta
    0x00800, 800,   -- East Sarutabaruta
    0x01000, 1000,  -- Tahrongi Canyon
    0x02000, 1000,  -- Buburimu Peninsula
    0x04000, 1000,  -- Meriphataud Mountains
    0x08000, 10000, -- Sauromugue Champaign
    0x10000, 10000  -- Batallia Downs
}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.AN_EXPLORER_S_FOOTSTEPS) == QUEST_ACCEPTED and
        npcUtil.tradeHas(trade, 570)
    then
        local tablets = player:getCharVar("anExplorer-ClayTablets")
        local currtab = player:getCharVar("anExplorer-CurrentTablet")

        if currtab ~= 0 and (tablets % (2 * currtab)) < currtab then -- new tablet
            for zone = 1, #zoneId, 2 do
                if tablets % (2 * zoneId[zone]) < zoneId[zone] then
                    if (tablets + currtab) == 0x1ffff then
                        player:startEvent(47)
                        break
                    end

                    if zoneId[zone] == currtab then
                        player:startEvent(41) -- the tablet he asked for
                    else
                        player:startEvent(46) -- not the one he asked for
                    end

                    player:setCharVar("anExplorer-ClayTablets", tablets + currtab)
                    break
                end
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    local anExplorersFootsteps = player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.AN_EXPLORER_S_FOOTSTEPS)

    -- AN EXPLORER'S FOOTSTEPS
    if
        anExplorersFootsteps == QUEST_AVAILABLE and
        player:getFameLevel(xi.quest.fame_area.SELBINA_RABAO) >= 1
    then
        player:startEvent(40)
    elseif anExplorersFootsteps == QUEST_ACCEPTED then
        if
            not player:hasItem(xi.items.CLAY_TABLET) and
            not player:hasItem(xi.items.LUMP_OF_SELBINA_CLAY)
        then
            if player:getCharVar("anExplorer-CurrentTablet") == -1 then
                player:startEvent(42)
            else
                player:startEvent(44)
                player:setCharVar("anExplorer-CurrentTablet", 0)
            end
        else
            local tablets = player:getCharVar("anExplorer-ClayTablets")

            for zone = 1, #zoneId, 2 do
                if tablets % (2 * zoneId[zone]) < zoneId[zone] then
                    if zone < 20 then
                        player:startEvent(43, math.floor(zone / 2))
                    else
                        player:startEvent(49, math.floor(zone / 2) -10)
                    end

                    break
                end
            end
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- AN EXPLORER'S FOOTSTEPS
    if
        csid == 40 and
        option ~= 0 and
        npcUtil.giveItem(player, xi.items.LUMP_OF_SELBINA_CLAY)
    then
        player:addQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.AN_EXPLORER_S_FOOTSTEPS)
        player:setCharVar("anExplorer-ClayTablets", 0)
    elseif
        csid == 42 and
        option == 100 and
        npcUtil.giveItem(player, xi.items.LUMP_OF_SELBINA_CLAY)
    then
        player:setCharVar("anExplorer-CurrentTablet", 0)
    elseif csid == 44 then
        npcUtil.giveItem(player, xi.items.LUMP_OF_SELBINA_CLAY)
    elseif csid == 41 or csid == 46 or csid == 47 then
        local currtab = player:getCharVar("anExplorer-CurrentTablet")
        local tablets = player:getCharVar("anExplorer-ClayTablets")

        for zone = 1, #zoneId, 2 do
            if zoneId[zone] == currtab then
                player:confirmTrade()
                npcUtil.giveCurrency(player, 'gil', zoneId[zone + 1])
                player:setCharVar("anExplorer-CurrentTablet", 0)
                break
            end
        end

        if csid == 47 then
            player:completeQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.AN_EXPLORER_S_FOOTSTEPS)
            player:setCharVar("anExplorer-ClayTablets", 0)
        end

        if option == 100 then
            npcUtil.giveItem(player, xi.items.LUMP_OF_SELBINA_CLAY)
        elseif option == 110 then
            player:setCharVar("anExplorer-CurrentTablet", -1)
        end

        if (tablets % (2 * 0x7fff)) >= 0x7fff then
            npcUtil.giveKeyItem(player, xi.ki.MAP_OF_THE_CRAWLERS_NEST)
        end
    end
end

return entity
