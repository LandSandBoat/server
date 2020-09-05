-----------------------------------
-- Area: Windurst Woods
--  NPC: Cha Lebagta
-- Type: Standard NPC
-- !pos 58.385 -6.249 216.670 241
--    Involved in Quests: As Thick as Thieves, Mihgo's Amigo
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local MihgosAmigo = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.MIHGO_S_AMIGO)
    local thickAsThieves = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.AS_THICK_AS_THIEVES)
    local thickAsThievesCS = player:getCharVar("thickAsThievesCS")

    -- As Thick As Thieves (THF AF)
    if thickAsThieves == QUEST_ACCEPTED then
        player:startEvent(507, 0, 17474)
        if thickAsThievesCS == 1 then
            player:setCharVar("thickAsThievesCS", 3)
        elseif thickAsThievesCS == 2 then
            player:setCharVar("thickAsThievesCS", 4)
            local rand1 = math.random(2, 7)
            player:setCharVar("thickAsThievesGrapplingCS", rand1)
            player:setCharVar("thickAsThievesGamblingCS", 1)
        end

    -- Mihgo's Amigo
    elseif MihgosAmigo == QUEST_ACCEPTED then
        player:startEvent(85, 0, 498) -- hint dialog

    -- standard dialog
    elseif MihgosAmigo == QUEST_COMPLETED then
        player:startEvent(91, 0, 498) -- new standard dialog after Mihgo's Amigo
    else
        player:startEvent(78) -- normal dialog
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
