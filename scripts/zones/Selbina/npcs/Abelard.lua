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
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------

local ZoneID =
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

function onTrade(player, npc, trade)
    if player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.AN_EXPLORER_S_FOOTSTEPS) == QUEST_ACCEPTED and npcUtil.tradeHas(trade, 570) then
        local tablets = player:getCharVar("anExplorer-ClayTablets")
        local currtab = player:getCharVar("anExplorer-CurrentTablet")

        if currtab ~= 0 and (tablets % (2 * currtab)) < currtab then -- new tablet
            for zone = 1, #ZoneID, 2 do
                if tablets % (2 * ZoneID[zone]) < ZoneID[zone] then
                    if (tablets + currtab) == 0x1ffff then
                        player:startEvent(47)
                        break
                    end

                    if ZoneID[zone] == currtab then
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

    if
        player:getCurrentMission(ROV) == tpz.mission.id.rov.SET_FREE and
        npcUtil.tradeHas(trade,{{9082, 3}}) and
        player:getCharVar("RhapsodiesStatus") == 1
    then
        player:startEvent(178)
    end
end

function onTrigger(player, npc)
    local anExplorersFootsteps = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.AN_EXPLORER_S_FOOTSTEPS)
    local signedInBlood = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.SIGNED_IN_BLOOD)
    local signedInBloodStat = player:getCharVar("SIGNED_IN_BLOOD_Prog")

    -- SIGNED IN BLOOD (will only activate if An Explorer's Footsteps is not active, or if it is completed)
    if signedInBlood == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.TORN_OUT_PAGES) and anExplorersFootsteps ~= QUEST_ACCEPTED and signedInBloodStat == 2 then
        player:startEvent(1106)
    elseif signedInBlood == QUEST_ACCEPTED and signedInBloodStat == 1 and anExplorersFootsteps ~= QUEST_ACCEPTED then
        player:startEvent(1104)
    elseif signedInBlood == QUEST_ACCEPTED and signedInBloodStat == 2 and anExplorersFootsteps ~= QUEST_ACCEPTED then
        player:startEvent(1105)
    elseif signedInBlood == QUEST_ACCEPTED and signedInBloodStat == 3 then
        player:startEvent(48)

    -- AN EXPLORER'S FOOTSTEPS
    elseif anExplorersFootsteps == QUEST_AVAILABLE and math.floor((player:getFameLevel(SANDORIA) + player:getFameLevel(BASTOK)) / 2) >= 1 then
        player:startEvent(40)
    elseif anExplorersFootsteps == QUEST_ACCEPTED then
        if not player:hasItem(570) and not player:hasItem(571) then
            if player:getCharVar("anExplorer-CurrentTablet") == -1 then
                player:startEvent(42)
            else
                player:startEvent(44)
                player:setCharVar("anExplorer-CurrentTablet", 0)
            end
        else
            local tablets = player:getCharVar("anExplorer-ClayTablets")

            for zone = 1, #ZoneID, 2 do
                if tablets % (2*ZoneID[zone]) < ZoneID[zone] then
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

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- SIGNED IN BLOOD
    if csid == 1104 then
        player:setCharVar("SIGNED_IN_BLOOD_Prog", 2)
    elseif csid == 1106 then
        player:setCharVar("SIGNED_IN_BLOOD_Prog", 3)

    -- AN EXPLORER'S FOOTSTEPS
    elseif csid == 40 and option ~= 0 and npcUtil.giveItem(player, 571) then
        player:addQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.AN_EXPLORER_S_FOOTSTEPS)
        player:setCharVar("anExplorer-ClayTablets", 0)
    elseif csid == 42 and option == 100 and npcUtil.giveItem(player, 571) then
        player:setCharVar("anExplorer-CurrentTablet", 0)
    elseif csid == 44 then
        npcUtil.giveItem(player, 571)
    elseif csid == 41 or csid == 46 or csid == 47 then
        local currtab = player:getCharVar("anExplorer-CurrentTablet")
        local tablets = player:getCharVar("anExplorer-ClayTablets")

        for zone = 1, #ZoneID, 2 do
            if ZoneID[zone] == currtab then
                player:confirmTrade()
                player:addGil(GIL_RATE * ZoneID[zone+1])
                player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE * ZoneID[zone+1])
                player:setCharVar("anExplorer-CurrentTablet", 0)
                break
            end
        end

        if csid == 47 then
            player:completeQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.AN_EXPLORER_S_FOOTSTEPS)
            player:setCharVar("anExplorer-ClayTablets", 0)
        end

        if option == 100 then
            npcUtil.giveItem(player, 571)
        elseif option == 110 then
            player:setCharVar("anExplorer-CurrentTablet", -1)
        end

        if (tablets % (2 * 0x7fff)) >= 0x7fff then
            npcUtil.giveKeyItem(player, tpz.ki.MAP_OF_THE_CRAWLERS_NEST)
        end

    -- RoV: Set Free
    elseif csid == 178 then
        player:confirmTrade()
        if player:hasJob(0) == 0 then -- Is Subjob Unlocked
            npcUtil.giveKeyItem(player, tpz.ki.GILGAMESHS_INTRODUCTORY_LETTER)
        else
            if not npcUtil.giveItem(player, 8711) then return end
        end
        player:completeMission(ROV, tpz.mission.id.rov.SET_FREE)
        player:addMission(ROV, tpz.mission.id.rov.THE_BEGINNING)
    end
end
