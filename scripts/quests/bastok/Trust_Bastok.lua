-----------------------------------
-- Trust: Bastok
-----------------------------------
-- !addquest 1 92
-- Clarion Star : !pos 81.478 7.500 -24.169 236
-- Naji         : !pos 64 -14 -4 237
-----------------------------------
local metalworksID = zones[xi.zone.METALWORKS]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRUST_BASTOK)

quest.reward =
{
    keyItem = xi.ki.BASTOK_TRUST_PERMIT,
}

local function trustMemoryAyame(player)
    local memories = 0

    -- 2 - The Three Kingdoms
    if
        player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.JOURNEY_TO_BASTOK2) or
        player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS_BASTOK2)
    then
        memories = memories + 2
    end

    -- 4 - Where Two Paths Converge
    if player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE) then
        memories = memories + 4
    end

    -- 8 - The Pirate's Cove
    if player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_PIRATES_COVE) then
        memories = memories + 8
    end

    -- 16 - Ayame and Kaede
    if player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.AYAME_AND_KAEDE) then
        memories = memories + 16
    end

    -- 32 - Light of Judgement
    if player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.LIGHT_OF_JUDGMENT) then
        memories = memories + 32
    end

    -- 64 - True Strength
    if player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRUE_STRENGTH) then
        memories = memories + 64
    end

    return memories
end

local function trustMemoryIronEater(player)
    local memories = 0
    --[[ TODO
    -- 2 - The Three Kingdoms
    if player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.JOURNEY_TO_BASTOK2) or player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS_BASTOK2) then
        memories = memories + 2
    end
    -- 4 - Where Two Paths Converge
    if player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE) then
        memories = memories + 4
    end
    -- 8 - The Pirate's Cove
    if player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_PIRATES_COVE) then
        memories = memories + 8
    end
    -- 16 - Ayame and Kaede
    if player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.AYAME_AND_KAEDE) then
        memories = memories + 16
    end
    -- 32 - Light of Judgement
    if player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.LIGHT_OF_JUDGMENT) then
        memories = memories + 32
    end
    -- 64 - True Strength
    if player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRUE_STRENGTH) then
        memories = memories + 64
    end
    ]]--

    -- Incident with Volker and Zeid
    -- Bring together Mythril Musketeers
    -- Mastery over the way of the axe
    -- Galka grieving over the loss of their homeland
    -- Piece of wood Werei left behind
    -- Help nenew ties with Raogrimm and Deidogg
    -- Chose to become an adventurer in the past
    -- Aht Urhgan, Zazarg
    -- Republican Iron Medal

    return memories
end

local function trustMemoryNaji(player)
    local memories = 0

    if player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY) then
        memories = memories + 2
    end

    if player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_DOORMAN) then
        memories = memories + 4
    end

    if player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.LIGHT_OF_JUDGMENT) then
        memories = memories + 8
    end

    -- 16 - Chocobo racing
    --  memories = memories + 16

    return memories
end

local function trustMemoryVolker(player)
    local memories = 0

    -- 2 - Darkness Rising (Bastok Mission)
    if player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.DARKNESS_RISING) then
        memories = memories + 2
    end

    -- 4 - Where Two Paths Converge (Bastok Mission)
    if player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE) then
        memories = memories + 4
    end

    -- 8 - Light of Judgment (Aht Urhgan Mission)
    if player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.LIGHT_OF_JUDGMENT) then
        memories = memories + 8
    end

    -- 16 - Hero's Combat (BCNM)
    -- if (playervar for Hero's Combat) then
    --  memories = memories + 16
    -- end

    return memories
end

quest.sections =
{
    -- Section: Quest available
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainLvl() >= 5 and
                xi.settings.main.ENABLE_TRUST_QUESTS == 1
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Clarion_Star'] =
            {
                onTrigger = function(player, npc)
                    local trustSandoria = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TRUST_SANDORIA)
                    local trustWindurst = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TRUST_WINDURST)

                    if trustWindurst == QUEST_AVAILABLE and trustSandoria == QUEST_AVAILABLE then
                        return quest:progressEvent(434)
                    elseif trustWindurst == QUEST_COMPLETED or trustSandoria == QUEST_COMPLETED then
                        return quest:progressEvent(438)
                    end
                end,
            },

            onEventFinish =
            {
                [434] = function(player, csid, option, npc)
                    if option == 2 then
                        quest:begin(player)
                        npcUtil.giveKeyItem(player, xi.ki.BLUE_INSTITUTE_CARD)
                    end
                end,

                [438] = function(player, csid, option, npc)
                    if option == 2 then
                        quest:begin(player)
                        npcUtil.giveKeyItem(player, xi.ki.BLUE_INSTITUTE_CARD)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.METALWORKS] =
        {
            ['Naji'] =
            {
                onTrigger = function(player, npc)
                    local rank3 = player:getRank(player:getNation()) >= 3 and 1 or 0
                    local bastokFirstTrust = quest:getVar(player, 'Prog')

                    if
                        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TRUST_SANDORIA) == QUEST_COMPLETED or
                        player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TRUST_WINDURST) == QUEST_COMPLETED
                    then
                        return quest:progressEvent(984, 0, 0, 0, trustMemoryNaji(player), 0, 0, 0, rank3)
                    elseif bastokFirstTrust == 0 then
                        return quest:progressEvent(980, 0, 0, 0, trustMemoryNaji(player), 0, 0, 0, rank3)
                    elseif bastokFirstTrust == 1 then
                        return quest:progressEvent(981):oncePerZone()
                    elseif bastokFirstTrust == 2 then
                        return quest:progressEvent(982)
                    end
                end,
            },

            onEventFinish =
            {
                [980] = function(player, csid, option, npc)
                    player:addSpell(xi.magic.spell.NAJI, true, true)
                    player:messageSpecial(metalworksID.text.YOU_LEARNED_TRUST, 0, xi.magic.spell.NAJI)
                    quest:setVar(player, 'Prog', 1)
                end,

                [982] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:addTitle(xi.title.THE_TRUSTWORTHY)
                        player:delKeyItem(xi.ki.BLUE_INSTITUTE_CARD)
                        player:messageSpecial(metalworksID.text.KEYITEM_LOST, xi.ki.BLUE_INSTITUTE_CARD)
                        player:messageSpecial(metalworksID.text.CALL_MULTIPLE_ALTER_EGO)
                    end
                end,

                [984] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:addSpell(xi.magic.spell.NAJI, true, true)
                        player:messageSpecial(metalworksID.text.YOU_LEARNED_TRUST, 0, xi.magic.spell.NAJI)
                        player:delKeyItem(xi.ki.BLUE_INSTITUTE_CARD)
                        player:messageSpecial(metalworksID.text.KEYITEM_LOST, xi.ki.BLUE_INSTITUTE_CARD)
                    end
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Clarion_Star'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.BLUE_INSTITUTE_CARD) then
                        return quest:progressEvent(435)
                    end
                end,
            },
        },
    },

    -- Section: Quest completed
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.METALWORKS] =
        {
            ['Ayame'] =
            {
                onTrigger = function(player, npc)
                    local rank3 = player:getRank(player:getNation()) >= 3 and 1 or 0

                    if not player:hasSpell(xi.magic.spell.AYAME) then
                        return quest:event(985, 0, 0, 0, trustMemoryAyame(player), 0, 0, 0, rank3)
                    end
                end,
            },

            ['Iron_Eater'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasSpell(xi.magic.spell.NAJI) and
                        player:hasSpell(xi.magic.spell.AYAME) and
                        player:hasSpell(xi.magic.spell.VOLKER) and
                        not player:hasSpell(xi.magic.spell.IRON_EATER)
                    then
                        return quest:progressEvent(988, 0, 0, 0, trustMemoryIronEater(player)):oncePerZone()
                    end
                end,
            },

            ['Lucius'] =
            {
                onTrigger = function(player, npc)
                    local rank6 = player:getRank(player:getNation()) >= 6 and 1 or 0

                    if not player:hasSpell(xi.magic.spell.VOLKER) then
                        return quest:event(986, 0, 0, 0, trustMemoryVolker(player), 0, 0, 0, rank6)
                    end
                end,
            },

            ['Naji'] =
            {
                onTrigger = function(player, npc)
                    local rank3 = player:getRank(player:getNation()) >= 3 and 1 or 0

                    if not player:hasSpell(xi.magic.spell.AYAME) then
                        return quest:progressEvent(983, 0, 0, 0, 0, 0, 0, 0, rank3):oncePerZone()
                    end
                end,
            },

            onEventFinish =
            {
                [985] = function(player, csid, option, npc)
                    if option == 2 then
                        player:addSpell(xi.magic.spell.AYAME, true, true)
                        player:messageSpecial(metalworksID.text.YOU_LEARNED_TRUST, 0, xi.magic.spell.AYAME)
                    end
                end,

                [986] = function(player, csid, option, npc)
                    if option == 2 then
                        player:addSpell(xi.magic.spell.VOLKER, true, true)
                        player:messageSpecial(metalworksID.text.YOU_LEARNED_TRUST, 0, xi.magic.spell.VOLKER)
                    end
                end,

                [988] = function(player, csid, option, npc)
                    if option == 2 then
                        player:addSpell(xi.magic.spell.IRON_EATER, true, true)
                        player:messageSpecial(metalworksID.text.YOU_LEARNED_TRUST, 0, xi.magic.spell.IRON_EATER)
                    end
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Clarion_Star'] = quest:progressEvent(436),
        },
    },
}

return quest
