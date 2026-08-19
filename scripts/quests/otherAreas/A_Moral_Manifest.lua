-----------------------------------
-- A Moral Manifest
-----------------------------------
-- Log ID: 4, Quest ID: 108
-- !addquest 4 108
-- Hooknox   : !pos -265.248 12.693 -102.547 152
-- Stone Lid : !pos -316.439 24.765 10.159 152
-- Ponono    : !pos -38.243 -1.250 -120.954 241
-----------------------------------
-- Events 701 and 703 are reminders and alternate with Ponono's guild master menu on successive clicks.
-- Event 704 sells a replacement cutting for 100,000 gil.
-- Events 701 and 704 both offer to cancel the quest. Confirming both prompts returns 100.
-- The cutting is ready at the next Vana'diel midnight. No zone change is required.
-- Hooknox withholds the offer while another beastman headgear quest is accepted,
-- or while a hero headpiece is equipped.
--
-- Source: https://wiki.ffo.jp/html/15809.html
-----------------------------------
local altarRoomID     = zones[xi.zone.ALTAR_ROOM]
local windurstWoodsID = zones[xi.zone.WINDURST_WOODS]
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.A_MORAL_MANIFEST)

quest.reward =
{
    item = xi.item.GOLD_BEASTCOIN,
}

local heroHeadpieces =
{
    xi.item.CHOPLIXS_COIF,
    xi.item.DAVHUS_BARBUT,
    xi.item.GADZRADDS_HELM,
    xi.item.TSOO_HAJAS_HEADGEAR,
}

local beastmanHeadgearQuests =
{
    xi.quest.id.otherAreas.AN_AFFABLE_ADAMANTKING,
    xi.quest.id.otherAreas.AN_UNDERSTANDING_OVERLORD,
    xi.quest.id.otherAreas.A_GENEROUS_GENERAL,
}

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            if
                status ~= xi.questStatus.QUEST_AVAILABLE or
                player:getMainLvl() < 60 or
                quest:getVar(player, 'Declined') ~= 0
            then
                return false
            end

            local headpiece = player:getEquipID(xi.slot.HEAD)

            for _, itemId in ipairs(heroHeadpieces) do
                if headpiece == itemId then
                    return false
                end
            end

            for _, questId in ipairs(beastmanHeadgearQuests) do
                if player:getQuestStatus(xi.questLog.OTHER_AREAS, questId) == xi.questStatus.QUEST_ACCEPTED then
                    return false
                end
            end

            return true
        end,

        [xi.zone.ALTAR_ROOM] =
        {
            ['Hooknox'] = quest:progressEvent(46),

            onZoneIn = function(player, prevZone)
                return 46
            end,

            onEventFinish =
            {
                [46] = function(player, csid, option, npc)
                    -- Refusing either of Hooknox's two prompts returns 1.
                    if option == 0 then
                        quest:begin(player)
                    elseif option == 1 then
                        quest:setVar(player, 'Declined', 1, NextConquestTally())
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.ALTAR_ROOM] =
        {
            ['Stone_Lid'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 6 and
                        npcUtil.tradeMatches(trade, { { xi.item.YAGUDO_HEADGEAR, 1 } })
                    then
                        return quest:progressEvent(50)
                    end
                end,

                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if
                        progress == 4 and
                        player:getEquipID(xi.slot.HEAD) == xi.item.YAGUDO_HEADGEAR
                    then
                        -- Retail prints the placement line before the cutscene begins.
                        player:messageSpecial(altarRoomID.text.PLACE_ON_STONE_LID, xi.ki.VAULT_QUIPUS)

                        return quest:progressEvent(48)
                    elseif progress == 5 then
                        return quest:progressEvent(49)
                    end
                end,
            },

            ['Yagudo_Avatar'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 4 then
                        quest:setVar(player, 'Prog', 5)
                        player:delKeyItem(xi.ki.VAULT_QUIPUS)
                    end
                end,
            },

            onZoneIn = function(player, prevZone)
                local progress = quest:getVar(player, 'Prog')

                if
                    progress == 3 and
                    player:getEquipID(xi.slot.HEAD) == xi.item.YAGUDO_HEADGEAR
                then
                    return 47
                elseif
                    progress == 7 and
                    player:getEquipID(xi.slot.HEAD) == xi.item.TSOO_HAJAS_HEADGEAR
                then
                    return 51
                end
            end,

            onEventFinish =
            {
                [47] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.VAULT_QUIPUS)
                    quest:setVar(player, 'Prog', 4)
                end,

                [48] = function(player, csid, option, npc)
                    npcUtil.popFromQM(player, npc,
                    {
                        altarRoomID.mob.YAGUDO_AVATAR,
                        altarRoomID.mob.DUU_MASA_THE_ONECUT,
                        altarRoomID.mob.FEE_JUGE_THE_RAMFIST,
                        altarRoomID.mob.GOO_PAKE_THE_BLOODHOUND,
                        altarRoomID.mob.KEE_TAW_THE_NIGHTINGALE,
                        altarRoomID.mob.LAA_YAKU_THE_AUSTERE,
                        altarRoomID.mob.POO_YOZO_THE_BABBLER,
                    }, { hide = 1 })
                end,

                [49] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 6)
                end,

                [50] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.TSOO_HAJAS_HEADGEAR, { fromTrade = true }) then
                        player:tradeComplete()
                        quest:setVar(player, 'Prog', 7)
                    end
                end,

                [51] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Ponono'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        npcUtil.tradeMatches(trade, { { xi.item.SQUARE_OF_VELVET_CLOTH, 1 }, { xi.item.SQUARE_OF_RAINBOW_CLOTH, 1 }, { xi.item.GIL, 10000 } })
                    then
                        return quest:progressEvent(702)
                    end
                end,

                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 0 then
                        return quest:progressEvent(700)

                    elseif progress == 1 then
                        return quest:event(701)

                    elseif
                        progress == 2 and
                        quest:getVar(player, 'Wait') > GetSystemTime()
                    then
                        return quest:event(703)

                    elseif progress == 2 then
                        return quest:progressEvent(705)

                    -- The headgear synthesis consumes the cutting.
                    elseif
                        progress == 3 and
                        not player:hasItem(xi.item.YAGUDO_HEADDRESS_CUTTING) and
                        not player:hasItem(xi.item.YAGUDO_HEADGEAR)
                    then
                        return quest:event(704)
                    end
                end,
            },

            onEventFinish =
            {
                [700] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [701] = function(player, csid, option, npc)
                    if option == 100 then
                        player:delQuest(quest.areaId, quest.questId)
                        quest:cleanup(player)
                    end
                end,

                [702] = function(player, csid, option, npc)
                    player:tradeComplete()
                    quest:setVar(player, 'Prog', 2)
                    quest:setVar(player, 'Wait', getVanaMidnight())
                end,

                [704] = function(player, csid, option, npc)
                    if option == 100 then
                        player:delQuest(quest.areaId, quest.questId)
                        quest:cleanup(player)
                        return
                    end

                    -- Refusing to pay returns 0x40000000. Only 0 accepts the price.
                    if option ~= 0 then
                        return
                    end

                    if player:getGil() < 100000 then
                        player:messageSpecial(windurstWoodsID.text.NOT_HAVE_ENOUGH_GIL)
                        return
                    end

                    player:delGil(100000)
                    quest:setVar(player, 'Prog', 2)
                    quest:setVar(player, 'Wait', getVanaMidnight())
                end,

                [705] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.YAGUDO_HEADDRESS_CUTTING) then
                        quest:setVar(player, 'Prog', 3)
                        quest:setVar(player, 'Wait', 0)
                    end
                end,
            },
        },
    },
}

return quest
