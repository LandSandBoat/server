-----------------------------------
-- Whence Blows the Wind
-----------------------------------
-- Log ID: 3, Quest ID: 130
-- Maat : !pos 8 3 118 243
-- qm1 (Monastic Caverns) : !pos 168 -1 -22 150
-- qm2 (Castle Oztroja)   : !pos -100 -63 58 151
-- qm1 (Qulun Dome)       : !pos 261 39 79 148
-----------------------------------
local ruludeID = zones[xi.zone.RULUDE_GARDENS]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.WHENCE_BLOWS_THE_WIND)

quest.reward =
{
    fame = 50,
    fameArea = xi.quest.fame_area.JEUNO,
    title = xi.title.SKY_BREAKER,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getLevelCap() == 60 and
                xi.settings.main.MAX_LEVEL >= 65
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Maat'] =
            {
                onTrigger = function(player, npc)
                    if player:getMainLvl() >= 56 then
                        return quest:progressEvent(85)
                    else
                        return quest:messageText(ruludeID.text.MAAT_LB3_PLACEHOLDER)
                    end
                end,
            },

            onEventFinish =
            {
                [85] = function(player, csid, option, npc)
                    if option == 1 then -- Accept quest option.
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Maat'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.ORCISH_CREST) and
                        player:hasKeyItem(xi.ki.QUADAV_CREST) and
                        player:hasKeyItem(xi.ki.YAGUDO_CREST)
                    then
                        return quest:progressEvent(87)
                    else
                        return quest:event(86)
                    end
                end,
            },

            onEventFinish =
            {
                [87] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.ORCISH_CREST)
                        player:delKeyItem(xi.ki.QUADAV_CREST)
                        player:delKeyItem(xi.ki.YAGUDO_CREST)
                        player:setLevelCap(65)
                        player:messageSpecial(ruludeID.text.YOUR_LEVEL_LIMIT_IS_NOW_65)
                    end
                end,
            },
        },

        [xi.zone.CASTLE_OZTROJA] =
        {
            ['qm2'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.YAGUDO_CREST) then
                        return quest:keyItem(xi.ki.YAGUDO_CREST)
                    end
                end,
            },
        },

        [xi.zone.MONASTIC_CAVERN] =
        {
            ['qm1'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.ORCISH_CREST) then
                        return quest:keyItem(xi.ki.ORCISH_CREST)
                    end
                end,
            },
        },

        [xi.zone.QULUN_DOME] =
        {
            ['qm1'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.QUADAV_CREST) then
                        return quest:keyItem(xi.ki.QUADAV_CREST)
                    end
                end,
            },
        },
    },
}

return quest
