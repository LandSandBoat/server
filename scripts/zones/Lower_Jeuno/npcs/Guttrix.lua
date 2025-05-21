-----------------------------------
-- Area: Lower Jeuno
--  NPC: Guttrix
-- Starts and Finishes Quest: The Goblin Tailor
-- !pos -36.010 4.499 -139.714 245
-----------------------------------
---@type TNpcEntity
local entity = {}

---@class rseMap : { [xi.race] : xi.item[] }
local rseMap =
{
    -- [race] = { body, hands, legs, feet }
    [xi.race.HUME_M  ] = { xi.item.CUSTOM_TUNIC,     xi.item.CUSTOM_M_GLOVES,  xi.item.CUSTOM_SLACKS,    xi.item.CUSTOM_M_BOOTS    },
    [xi.race.HUME_F  ] = { xi.item.CUSTOM_VEST,      xi.item.CUSTOM_F_GLOVES,  xi.item.CUSTOM_PANTS,     xi.item.CUSTOM_F_BOOTS    },
    [xi.race.ELVAAN_M] = { xi.item.MAGNA_JERKIN,     xi.item.MAGNA_GAUNTLETS,  xi.item.MAGNA_M_CHAUSSES, xi.item.MAGNA_M_LEDELSENS },
    [xi.race.ELVAAN_F] = { xi.item.MAGNA_BODICE,     xi.item.MAGNA_GLOVES,     xi.item.MAGNA_F_CHAUSSES, xi.item.MAGNA_F_LEDELSENS },
    [xi.race.TARU_M  ] = { xi.item.WONDER_KAFTAN,    xi.item.WONDER_MITTS,     xi.item.WONDER_BRACCAE,   xi.item.WONDER_CLOMPS     },
    [xi.race.TARU_F  ] = { xi.item.WONDER_KAFTAN,    xi.item.WONDER_MITTS,     xi.item.WONDER_BRACCAE,   xi.item.WONDER_CLOMPS     },
    [xi.race.MITHRA  ] = { xi.item.SAVAGE_SEPARATES, xi.item.SAVAGE_GAUNTLETS, xi.item.SAVAGE_LOINCLOTH, xi.item.SAVAGE_GAITERS    },
    [xi.race.GALKA   ] = { xi.item.ELDERS_SURCOAT,   xi.item.ELDERS_BRACERS,   xi.item.ELDERS_BRAGUETTE, xi.item.ELDERS_SANDALS    },
}

local function hasRSE(player)
    local mask = 0
    local rse = rseMap[player:getRace()]

    for i = 1, #rse do
        if player:hasItem(rse[i]) then
            mask = mask + 2 ^ (i - 1)
        end
    end

    return mask
end

entity.onTrigger = function(player, npc)
    local questStatus = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_GOBLIN_TAILOR)
    local rseGear     = hasRSE(player)
    local rseRace     = VanadielRSERace()
    local rseLocation = VanadielRSELocation()

    if
        player:getMainLvl() >= 10 and
        player:getFameLevel(xi.fameArea.JEUNO) >= 3
    then
        if rseGear < 15 then
            if questStatus == xi.questStatus.QUEST_AVAILABLE then
                player:startEvent(10016, rseLocation, rseRace)
            elseif
                questStatus >= xi.questStatus.QUEST_ACCEPTED and
                player:hasKeyItem(xi.ki.MAGICAL_PATTERN)
            then
                player:startEvent(10018, rseGear)
            else
                player:startEvent(10017, rseLocation, rseRace)
            end
        else
            player:startEvent(10019)
        end
    else
        player:startEvent(10020)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local questStatus = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_GOBLIN_TAILOR)

    if csid == 10016 then
        player:addQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_GOBLIN_TAILOR)
    elseif
        csid == 10018 and
        option >= 1 and
        option <= 4 and
        questStatus >= xi.questStatus.QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.MAGICAL_PATTERN)
    then
        if npcUtil.giveItem(player, rseMap[player:getRace()][option]) then
            if questStatus == xi.questStatus.QUEST_ACCEPTED then
                player:addFame(xi.fameArea.JEUNO, 30)
                player:completeQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_GOBLIN_TAILOR)
            end

            player:delKeyItem(xi.ki.MAGICAL_PATTERN)
        end
    end
end

return entity
