-----------------------------------
-- Emissaries of God
-----------------------------------
-- !addquest 8 182
-- Joachim      : !pos -52.844 0 -9.978 246
-- Caturae NMs  :
--   Iratham  (Abyssea - Tahrongi)  : !spawnmob 16961945
--   Kutharei (Abyssea - Misareaux) : !spawnmob 17662497
--   Sippoy   (Abyssea - Vunkerl)   : !spawnmob 17666511
--   Yaanei   (Abyssea - Attohwa)   : !spawnmob 17658292
--   Rani     (Abyssea - Altepa)    : !spawnmob 17670551
--   Raja     (Abyssea - Grauberg)  : !spawnmob 17818051
-- Flagged on completion of Death and Rebirth.
-- Obtain all 6 caturae titles, then talk to Joachim for CS and Abyssite of Discernment. Zone into the Hall of the Gods between 18:00 and 5:00. Flags Beneath a Blood-red Sky upon completion.
-----------------------------------

local quest = Quest:new(xi.questLog.ABYSSEA, xi.quest.id.abyssea.EMISSARIES_OF_GOD)

quest.reward = {} -- Key item given in first cutscene, not on quest complete

local caturaeTitles =
{
    xi.title.IRATHAM_CAPTURER,
    xi.title.KUTHAREI_UNHORSER,
    xi.title.SIPPOY_CAPTURER,
    xi.title.YAANEI_CRASHER,
    xi.title.RANI_DECROWNER,
    xi.title.RAJA_REGICIDE,
}

local function hasAllCaturaeTitles(player)
    for _, titleId in ipairs(caturaeTitles) do
        if not player:hasTitle(titleId) then
            return false
        end
    end

    return true
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and hasAllCaturaeTitles(player)
        end,

        [xi.zone.PORT_JEUNO] =
        {
            ['Joachim'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(344)
                end,
            },

            onEventFinish =
            {
                [344] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.ABYSSITE_OF_DISCERNMENT)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and quest:getVar(player, 'Prog') == 1
        end,

        [xi.zone.HALL_OF_THE_GODS] =
        {
            onZoneIn = function(player, prevZone)
                local hour = VanadielHour()
                if hour >= 18 or hour < 5 then
                    return 8
                end
            end,

            onEventFinish =
            {
                [8] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:addQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.BENEATH_A_BLOOD_RED_SKY)
                    end
                end,
            },
        },
    },
}

return quest
