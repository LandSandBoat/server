-----------------------------------
-- Area: Upper Jeuno
--  NPC: Luto Mewrilah
-- !pos -53 0 45 244
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/pets/fellow")
require("scripts/globals/fellow_utils")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/pets")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

local fellowWeapons =
{
    [1] =
    {
        Axe = { ID = 16640, Look = 16640 },
        Club = { ID = 17034, Look = 17034 },
        Dagger = { ID = 16465, Look = 16465 },
        Katana = { ID = 16896, Look = 16896 },
        Sword = { ID = 16535, Look = 16535 },
        Shield = { ID = 12289, Look = 12289 },
        HandToHand = { ID = 16385, Look = 16385 },
        GreatAxe = { ID = 16704, Look = 16704 },
        GreatKatana = { ID = 16960, Look = 16960 },
        GreatSword = { ID = 16583, Look = 16585 },
        Polearm = { ID = 16832, Look = 16832 },
        Scythe = { ID = 16768, Look = 16768 },
        Staff = { ID = 17088, Look = 17088 }
    },
    [2] =
    {
        Axe = { ID = 16641, Look = 16641 },
        Club = { ID = 17042, Look = 17042 },
        Dagger = { ID = 16449, Look = 16449 },
        Katana = { ID = 16900, Look = 16900 },
        Sword = { ID = 16530, Look = 16530 },
        Shield = { ID = 12415, Look = 12415 },
        HandToHand = { ID = 16390, Look = 16390 },
        GreatAxe = { ID = 16705, Look = 16705 },
        GreatKatana = { ID = 16982, Look = 16982 },
        GreatSword = { ID = 16589, Look = 16583 },
        Polearm = { ID = 16833, Look = 16833 },
        Scythe = { ID = 16769, Look = 16769 },
        Staff = { ID = 17089, Look = 17089 }
    },
    [3] =
    {
        Axe = { ID = 16643, Look = 16656 },
        Club = { ID = 17050, Look = 17050 },
        Dagger = { ID = 16455, Look = 16455 },
        Katana = { ID = 17776, Look = 16897 },
        Sword = { ID = 16552, Look = 16552 },
        Shield = { ID = 12299, Look = 12299 },
        HandToHand = { ID = 16406, Look = 16406 },
        GreatAxe = { ID = 18200, Look = 18214 },
        GreatKatana = { ID = 16975, Look = 16975 },
        GreatSword = { ID = 16594, Look = 16594 },
        Polearm = { ID = 16835, Look = 16836 },
        Scythe = { ID = 16774, Look = 16774 },
        Staff = { ID = 17096, Look = 17096 }
    },
    [4] =
    {
        Axe = { ID = 16650, Look = 16650 },
        Club = { ID = 17081, Look = 17081 },
        Dagger = { ID = 16473, Look = 16473 },
        Katana = { ID = 16907, Look = 16907 },
        Sword = { ID = 16566, Look = 16566 },
        Shield = { ID = 12292, Look = 12292 },
        HandToHand = { ID = 16411, Look = 16411 },
        GreatAxe = { ID = 18214, Look = 16706 },
        GreatKatana = { ID = 16962, Look = 16962 },
        GreatSword = { ID = 18375, Look = 18375 },
        Polearm = { ID = 16845, Look = 16845 },
        Scythe = { ID = 16770, Look = 16770 },
        Staff = { ID = 17424, Look = 17424 }
    },
    [5] =
    {
        Axe = { ID = 16644, Look = 16657 },
        Club = { ID = 17026, Look = 17026 },
        Dagger = { ID = 16460, Look = 16460 },
        Katana = { ID = 16901, Look = 17795 },
        Sword = { ID = 16513, Look = 16513 },
        Shield = { ID = 12306, Look = 12306 },
        HandToHand = { ID = 16399, Look = 16399 },
        GreatAxe = { ID = 18216, Look = 16710 },
        GreatKatana = { ID = 16970, Look = 16970 },
        GreatSword = { ID = 16584, Look = 16584 },
        Polearm = { ID = 16836, Look = 16837 },
        Scythe = { ID = 16775, Look = 16775 },
        Staff = { ID = 17091, Look = 17132 }
    },
    [6] =
    {
        Axe = { ID = 16657, Look = 16645 },
        Club = { ID = 17062, Look = 17467 },
        Dagger = { ID = 17610, Look = 16480 },
        Katana = { ID = 16902, Look = 16902 },
        Sword = { ID = 16553, Look = 16631 },
        Shield = { ID = 12300, Look = 12300 },
        HandToHand = { ID = 16419, Look = 16419 },
        GreatAxe = { ID = 16706, Look = 18218 },
        GreatKatana = { ID = 16967, Look = 16967 },
        GreatSword = { ID = 16590, Look = 16590 },
        Polearm = { ID = 16847, Look = 16849 },
        Scythe = { ID = 16796, Look = 16796 },
        Staff = { ID = 17098, Look = 17098 }
    },
    [7] =
    {
        Axe = { ID = 16651, Look = 17942 },
        Club = { ID = 17037, Look = 17454 },
        Dagger = { ID = 16468, Look = 18014 },
        Katana = { ID = 16903, Look = 16903 },
        Sword = { ID = 16519, Look = 17701 },
        Shield = { ID = 12307, Look = 12307 },
        HandToHand = { ID = 16401, Look = 18353 },
        GreatAxe = { ID = 18202, Look = 18206 },
        GreatKatana = { ID = 17802, Look = 17829 },
        GreatSword = { ID = 16595, Look = 16595 },
        Polearm = { ID = 16871, Look = 16871 },
        Scythe = { ID = 18050, Look = 18054 },
        Staff = { ID = 17523, Look = 17569 }
    },
}

local function updateMatchingFellowWeapon(player, maxWeaponlevel, trade)
    local weapon = nil
    for i = 1, maxWeaponlevel do
        for k, v in pairs(fellowWeapons[i]) do
            if npcUtil.tradeHasExactly(trade, v.ID) then
                weapon = v.ID
                if k == "Shield" then
                    player:setFellowValue("sub", weapon)
                else
                    player:setFellowValue("main", weapon)
                end
            end
        end
    end

    return weapon
end

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, 14810) and player:getLocalVar("StartOver") == 1 then
        local fellowParam = xi.fellow_utils.getFellowParam(player)
        player:startEvent(10049, 244, 0, 0, 0, 0, 0, 0, fellowParam)
        return
    end

    local unlistedQualities = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.UNLISTED_QUALITIES)
    if unlistedQualities == QUEST_COMPLETED then
        local weaponlevel = player:getFellowValue("weaponlvl")
        local weapon = updateMatchingFellowWeapon(player, weaponlevel, trade)
        if weapon == nil then
            -- no match found
            return
        end

        player:confirmTrade()
        local fellowParam = xi.fellow_utils.getFellowParam(player)
        player:startEvent(10052, 0, weapon, 0, 0, 0, 0, 0, fellowParam)
    end
end

-- Disable cyclomatic complexity check for this function:
-- luacheck: ignore 561
-- TODO: Reduce complexity in this function by converting to IF
entity.onTrigger = function(player, npc)
    local wildcatJeuno = player:getCharVar("WildcatJeuno")
    local unlistedQualities = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.UNLISTED_QUALITIES)
    local unlistedQualitiesProgress = player:getCharVar("[Quest]Unlisted_Qualities")
    local lookingGlass = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.GIRL_IN_THE_LOOKING_GLASS)
    local lookingGlassProgress = player:getCharVar("[Quest]Looking_Glass")
    local mirrorMirror = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.MIRROR_MIRROR)
    local mirrorMirrorProgress = player:getCharVar("[Quest]Mirror_Mirror")
    local needToZone = player:needToZone()
    local fellowParam = 0
    local bond = 0
    local weaponlevel = 0
    if unlistedQualities == QUEST_COMPLETED then
        fellowParam = xi.fellow_utils.getFellowParam(player)
        bond = player:getFellowValue("bond")
        weaponlevel = player:getFellowValue("weaponlvl")
    end

    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatJeuno, 7)
    then
        player:startEvent(10085)
    elseif
        unlistedQualities == QUEST_AVAILABLE and
        player:getRank(player:getNation()) >= 4 and -- Rank 4 not required after 2013
        xi.settings.main.ENABLE_ADVENTURING_FELLOWS
    then
        player:startEvent(10031)
    elseif
        unlistedQualities == QUEST_ACCEPTED and
        unlistedQualitiesProgress < 15
    then
        player:startEvent(10033)
    elseif
        unlistedQualities == QUEST_ACCEPTED and
        unlistedQualitiesProgress == 15
    then
        player:startEvent(10032)
    elseif
        unlistedQualities == QUEST_COMPLETED and
        lookingGlass < QUEST_ACCEPTED and
        needToZone
    then
        player:startEvent(10034)
    elseif
        unlistedQualities == QUEST_COMPLETED and
        lookingGlass == QUEST_AVAILABLE
    then
        player:startEvent(10039)
    elseif
        lookingGlass == QUEST_ACCEPTED and
        lookingGlassProgress < 4
    then
        player:startEvent(10042)
    elseif
        lookingGlass == QUEST_ACCEPTED and
        lookingGlassProgress == 4
    then
        player:startEvent(10043, 244, 0, 0, 0, 0, 0, 0, fellowParam)
    elseif
        lookingGlass == QUEST_COMPLETED and
        mirrorMirror < QUEST_ACCEPTED and
        needToZone
    then
        player:startEvent(10048)
    elseif
        lookingGlass == QUEST_COMPLETED and
        mirrorMirror == QUEST_AVAILABLE
    then
        player:startEvent(10044, 244, 0, 0, 0, 0, 0, 0, fellowParam)
    elseif
        mirrorMirror == QUEST_ACCEPTED and
        mirrorMirrorProgress < 3
    then
        player:startEvent(10045)
    elseif
        mirrorMirror == QUEST_ACCEPTED and
        mirrorMirrorProgress == 3
    then
        player:startEvent(10046, 244, 14810, 0, 0, 0, 0, 0, fellowParam)
    elseif
        mirrorMirror == QUEST_COMPLETED and
        player:getLocalVar("StartOver") == 1
    then
        player:startEvent(10053, 244, 14810, 0, 0, 0, 0, 0, fellowParam)
    elseif mirrorMirror == QUEST_COMPLETED then
        if
            player:getEquipID(xi.slot.EAR1) == 14810 or
            player:getEquipID(xi.slot.EAR2) == 14810
        then
            if
                bond >= 10 and
                weaponlevel == 0
            then
                player:startEvent(10050, 0, 0, 0, 0, 0, 0, 0, fellowParam)
            elseif
                bond >= 20 and
                weaponlevel == 1
            then
                player:startEvent(10051, 0, 0, 0, 0, 0, 0, 0, fellowParam)
            elseif
                bond >= 40 and
                weaponlevel == 2
            then
                player:startEvent(10068, 0, 0, 0, 0, 0, 0, 0, fellowParam)
            elseif
                bond >= 50 and
                weaponlevel == 3
            then
                player:startEvent(10069, 0, 0, 0, 0, 0, 0, 0, fellowParam)
            elseif
                bond >= 60 and
                weaponlevel == 4
            then
                player:startEvent(10070, 0, 0, 0, 0, 0, 0, 0, fellowParam)
            elseif
                bond >= 90 and
                weaponlevel == 5
            then
                player:startEvent(10076, 0, 0, 0, 0, 0, 0, 0, fellowParam)
            elseif
                bond >= 110 and
                weaponlevel == 6
            then
                player:startEvent(10077, 0, 0, 0, 0, 0, 0, 0, fellowParam)
            else
                player:startEvent(10047, 244, 14810, 0, 0, 0, 0, 0, fellowParam)
            end
        else
            player:startEvent(10047, 244, 14810, 0, 0, 0, 0, 0, fellowParam)
        end
    else
        player:startEvent(10041) -- Standard dialog
    end
end

-- 10031  10032  10033  10034  10039  10041  10044  10042  10048  10045  10047  10071  10053  10049
-- 10050  10051  10068  10069  10070  10076  10077  10052  10043  10046  10055  10056  10057  10058
-- 10060  10059  10061  10062  10063  10064  10067  10065  10066  10072  10073  10074  10075  10078
-- 10079  10080  10081  10082  10085  10174  10175

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10085 then
        player:setCharVar("WildcatJeuno", utils.mask.setBit(player:getCharVar("WildcatJeuno"), 7, true))
    elseif
        csid == 10031 and
        option >= 0 and
        option <= 119
    then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.UNLISTED_QUALITIES)
        player:setFellowValue("fellowid", option)
--[[
Adventuring Fellow Name Options:
    Male Hume:
        0   Feliz
        1   Ferdinand
        2   Gunnar
        3   Massimo
        4   Oldrich
        5   Siegward
        6   Theobald
        7   Zenji
    Female Hume:
        16  Amerita
        17  Beatrice
        18  Henrietta
        19  Jesimae
        20  Karyn
        21  Nanako
        22  Sharlene
        23  Sieghilde
    Male Elvaan:
        32  Chanandit
        33  Deulmaeux
        34  Demresinaux
        35  Ephealgaux
        36  Gauldeval
        37  Grauffemart
        38  Migaifongut
        39  Romidiant
    Female Elvaan:
        48  Armittie
        49  Cadepure
        50  Clearite
        51  Epilleve
        52  Liabelle
        53  Nauthima
        54  Radille
        55  Vimechue
    Male Taru:
        64  Balu-Falu
        65  Burg-Ladarg
        66  Ehgo-Ryuhgo
        67  Kolui-Pelui
        68  Nokum-Akkum
        69  Savul-Kivul
        70  Vinja-Kanja
        71  Yarga-Umiga
    Female Taru:
        80  Cupapa
        81  Jajuju
        82  Kalokoko
        83  Mahoyaya
        84  Pakurara
        85  Ripokeke
        86  Yawawa
        87  Yufafa
    Mithra:
        96  Fhig Lahrv
        97  Khuma Tagyawhan
        98  Pimy Kettihl
        99  Raka Maimhov
        100 Sahyu Banjyao
        101 Sufhi Uchnouma
        102 Tsuim Nhomango
        103 Yoli Kohlpaka
    Galka:
        112 Durib
        113 Dzapiwa
        114 Jugowa
        115 Mugido
        116 Voldai
        117 Wagwei
        118 Zayag
        119 Zoldof
--]]
    elseif csid == 10032 then
        if npcUtil.giveItem(player, 744) then
            player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.UNLISTED_QUALITIES)
            player:setCharVar("[Quest]Unlisted_Qualities", 0)
            player:needToZone(true)
        end
    elseif csid == 10039 then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.GIRL_IN_THE_LOOKING_GLASS)
        player:setCharVar("[Quest]Looking_Glass", 1)
    elseif csid == 10043 then
        player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.GIRL_IN_THE_LOOKING_GLASS)
        player:setCharVar("[Quest]Looking_Glass", 0)
        player:needToZone(true)
    elseif csid == 10044 then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.MIRROR_MIRROR)
        player:setCharVar("[Quest]Mirror_Mirror", 1)
    elseif csid == 10046 then
        if npcUtil.giveItem(player, 14810) then
            player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.MIRROR_MIRROR)
            player:setCharVar("[Quest]Mirror_Mirror", 0)
        end
    elseif
        csid == 10047 and
        option == 100
    then
        player:setLocalVar("StartOver", 1)
    elseif
        csid == 10053 and
        option == 101
    then
        player:setLocalVar("StartOver", 0)
    elseif csid == 10049 then
        player:delQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.CLASH_OF_THE_COMRADES)
        player:delQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.MIXED_SIGNALS)
        player:delQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.REGAINING_TRUST)
        player:delQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.CHAMELEON_CAPERS)
        player:delQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.MIRROR_IMAGES)
        player:delQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BLESSED_RADIANCE)
        player:delQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BLIGHTED_GLOOM)
        player:delQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PAST_REFLECTIONS)
        player:delQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.MIRROR_MIRROR)
        player:delQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.GIRL_IN_THE_LOOKING_GLASS)
        player:delQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.UNLISTED_QUALITIES)
        player:delFellowValue()
        player:setLocalVar("StartOver", 0)
        player:confirmTrade()
    elseif csid == 10050 then
        player:setFellowValue("weaponlvl", 1)
    elseif csid == 10051 then
        player:setFellowValue("weaponlvl", 2)
    elseif csid == 10068 then
        player:setFellowValue("weaponlvl", 3)
    elseif csid == 10069 then
        player:setFellowValue("weaponlvl", 4)
    elseif csid == 10070 then
        player:setFellowValue("weaponlvl", 5)
    elseif csid == 10076 then
        player:setFellowValue("weaponlvl", 6)
    elseif csid == 10077 then
        player:setFellowValue("weaponlvl", 7)
    end
end

return entity
