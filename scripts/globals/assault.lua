-----------------------------------
-- Assault Utilities
-- desc: Common functionality for Assaults
-----------------------------------
require("scripts/globals/besieged")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/zone")
-----------------------------------
assaultUtil = {}
-----------------------------------
function assaultUtil.hasOrders(player)
    local orders = {xi.ki.LEUJAOAM_ASSAULT_ORDERS, xi.ki.MAMOOL_JA_ASSAULT_ORDERS, xi.ki.LEBROS_ASSAULT_ORDERS,
    xi.ki.PERIQIA_ASSAULT_ORDERS, xi.ki.ILRUSI_ASSAULT_ORDERS, xi.ki.NYZUL_ISLE_ASSAULT_ORDERS}

    for _, v in pairs(orders) do
        if player:hasKeyItem(v) then
            return true
        end
    end
    return false
end

function assaultUtil.onTriggerArmbandNPC(player, npc, csid1, csid2, csid3, csid4, csid5, csid6, csid7, beginningsKI, ORDERS)
    local toauMission = player:getCurrentMission(TOAU)
    local beginnings = player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.BEGINNINGS)

    -- IMMORTAL SENTRIES
    if toauMission == IMMORTAL_SENTRIES then
        if player:hasKeyItem(xi.ki.SUPPLIES_PACKAGE) then
            player:startEvent(csid1)
        elseif player:getVar("AhtUrganStatus") == 1 then
            player:startEvent(csid2)
        end

    -- BEGINNINGS
    elseif beginnings == QUEST_ACCEPTED then
        if not player:hasKeyItem(beginningsKI) then
            player:startEvent(csid3)
        else
            player:startEvent(csid4)
        end;

    -- ASSAULT
    elseif toauMission >= PRESIDENT_SALAHEEM then
        local IPpoint = player:getCurrency("imperial_standing")
        if player:getVar("assaultEntered") == 0 and player:hasKeyItem(ORDERS) and not player:hasKeyItem(xi.ki.ASSAULT_ARMBAND) then
            player:startEvent(csid5, 50, IPpoint)
        else
            player:startEvent(csid6)
        end

    -- DEFAULT DIALOG
    else
        player:startEvent(csid7)
    end
end

function assaultUtil.onEventFinishArmbandNPC(player, csid, option, csid1, csid2, csid3, beginningsKI)
    -- IMMORTAL SENTRIES
    if csid == csid1 and option == 1 then
        player:delKeyItem(xi.ki.SUPPLIES_PACKAGE)
        player:setVar("AhtUrganStatus", 1)

    -- BEGINNINGS
    elseif csid == csid2 then
        npcUtil.giveKeyItem(player, beginningsKI)

    -- ASSAULT
    elseif csid == csid3 and option == 1 then
        npcUtil.giveKeyItem(player, xi.ki.ASSAULT_ARMBAND)
        player:delCurrency("imperial_standing", 50)
    end
end

function assaultUtil.onAssaultTrigger(player, npc, CSID, ORDERS, indexID)
    if player:hasKeyItem(ORDERS) and player:getVar("assaultEntered") == 0 then
        local assaultID = player:getCurrentAssault()
        local level = assaultUtil.missionInfo[assaultID].suggestedLevel
        local armband = 0

        if player:hasKeyItem(xi.ki.ASSAULT_ARMBAND) then
            armband = 1
        end
        player:startEvent(CSID, assaultID, -4, 0, level, indexID, armband)
    else
        player:messageText(player, zones[player:getZoneID()].text.NOTHING_HAPPENS)
    end
end

function assaultUtil.onAssaultUpdate(player, csid, option, target, ORDERS, zoneID)
    local assaultID = player:getCurrentAssault()

    local cap = bit.band(option, 0x03)
    if (cap == 0) then
        cap = 0
    elseif (cap == 1) then
        cap = 70
    elseif (cap == 2) then
        cap = 60
    else
        cap = 50
    end

    player:setVar("AssaultCap", cap)

    if player:getGMLevel() == 0 and player:getPartySize() < ASSAULT_MIN_PARTY_SIZE then
        player:messageSpecial(zones[player:getZoneID()].text.PARTY_MIN_REQS, 3)
        player:instanceEntry(target, 1)
        return
    elseif player:checkSoloPartyAlliance() == 2 then
        player:messageText(player, zones[player:getZoneID()].text.MEMBER_NO_REQS + 1, false)
        player:instanceEntry(target, 1)
        return
    end

    local party = player:getParty()

    if party ~= nil then
        for _,v in ipairs(party) do
            if not v:hasKeyItem(ORDERS) or v:getCurrentAssault() ~= assaultID or v:getVar("assaultEntered") ~= 0 or v:getMainLvl() < 50 then
                player:messageText(player, zones[player:getZoneID()].text.MEMBER_NO_REQS, false)
                player:instanceEntry(target, 1)
                return
            elseif v:getZoneID() ~= player:getZoneID() or v:checkDistance(player) > 50 then
                player:messageText(player, zones[player:getZoneID()].text.MEMBER_TOO_FAR, false)
                player:instanceEntry(target, 1)
                return
            end
        end
    end

    player:createInstance(player:getCurrentAssault(), zoneID)
end

function assaultUtil.onAssaultonInstanceCreated(player, target, instance, endCS, destinationID)
    if instance then
        instance:setLevelCap(player:getVar("AssaultCap"))
        player:setInstance(instance)
        player:instanceEntry(target, 4)
        player:setVar("AssaultCap", 0)
        player:setVar("Assault_Armband", 1)
        player:delKeyItem(xi.ki.ASSAULT_ARMBAND)
        player:setLocalVar("Area", destinationID)

        local party = player:getParty()
        if (party ~= nil) then
            for _,v in ipairs(party) do
                if v:getID() ~= player:getID() and v:getZoneID() == player:getZoneID() then
                    v:setLocalVar("Area", destinationID)
                    v:setInstance(instance)
                    v:startEvent(endCS, destinationID)
                end
            end
        end
    else
        player:messageText(player, zones[player:getZoneID()].text.CANNOT_ENTER, false)
        player:instanceEntry(target, 3)
    end
end

function assaultUtil.afterInstanceRegister(player, fireFlies, textTable, mobTable)
    local instance = player:getInstance()
    local assaultID = player:getCurrentAssault()
    local cap = instance:getLevelCap()

    for _, v in pairs(mobTable[assaultID].MOBS_START) do
        SpawnMob(v, instance)
    end

    player:messageSpecial(textTable.ASSAULT_START_OFFSET + assaultID, assaultID)
    player:messageSpecial(textTable.TIME_TO_COMPLETE, instance:getTimeLimit())
    player:addTempItem(fireFlies)
    if cap ~= 0 then
        player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, cap, 0, 0)
    end
    if player:getVar("Assault_Armband") == 1 then
        if cap ~= 0 then
            for _, v in pairs(mobTable[assaultID].MOBS_START) do
                if cap == 70 then
                    cap = 5
                elseif cap == 60 then
                    cap = 15
                elseif cap == 50 then
                    cap = 25
                end
                instance:getEntity(bit.band(v, 0xFFF), xi.objType.MOB):setMobLevel(instance:getEntity(bit.band(v, 0xFFF), xi.objType.MOB):getMainLvl() - cap)
            end
        end
    end
end

function assaultUtil.onInstanceFailure(instance, CSID, textTable)
    local chars = instance:getChars()
    local mobs = instance:getMobs()

    for _, v in pairs(mobs) do
        local mobID = v:getID()
        DespawnMob(mobID, instance)
    end

    for _, v in pairs(chars) do
        v:messageSpecial(textTable.MISSION_FAILED, 10, 10)
        v:startEvent(CSID)
    end
end

function assaultUtil.onInstanceComplete(player, instance, X, Z, textTable, npcTable)
    local chars = instance:getChars()

    for _,v in pairs(chars) do
        v:messageSpecial(textTable.RUNE_UNLOCKED_POS, X, Z)
    end

    instance:getEntity(bit.band(npcTable.RUNE_OF_RELEASE, 0xFFF), xi.objType.NPC):setStatus(xi.status.NORMAL)
    instance:getEntity(bit.band(npcTable.ANCIENT_LOCKBOX, 0xFFF), xi.objType.NPC):setStatus(xi.status.NORMAL)
end

function assaultUtil.instanceOnEventFinish(player, csid, endCS, ZONE)
    local instance = player:getInstance()
    local chars = instance:getChars()
    if csid == endCS then
        for _, v in pairs(chars) do
            v:setPos(0, 0, 0, 0, ZONE)
        end
    end
end

function assaultUtil.runeReleaseFinish(player, ASSAULT_POINT, textTable)
    local instance = player:getInstance()
    local chars = instance:getChars()
    local id = instance:getID()
    local playerpoints = math.max((#chars - 3) * .1, 0)
    local points = 0
    local assaultID = player:getCurrentAssault()
    local mobs = instance:getMobs()

    for _, v in pairs(mobs) do
        local mobID = v:getID()
        DespawnMob(mobID, instance)
    end
    for _, v in pairs(chars) do
        if v:getLocalVar("AssaultPointsAwarded") == 0 then
            v:setLocalVar("AssaultPointsAwarded", 1)

            local pointModifier = assaultUtil.missionInfo[assaultID].minimumPoints
            points = pointModifier - (pointModifier * playerpoints)
            if v:getVar("Assault_Armband") == 1 then
                points = points * (1.1)
            end
            if v:hasCompletedAssault(v:getCurrentAssault()) then
                points = math.floor(points)
                v:setVar("AssaultPromotion", v:getVar("AssaultPromotion") + 1)
                v:addAssaultPoint(ASSAULT_POINT, points)
                v:messageSpecial(textTable.ASSAULT_POINTS_OBTAINED, points)
            else
                points = math.floor(points*(1.5))
                v:setVar("AssaultPromotion", v:getVar("AssaultPromotion") + 5)
                v:addAssaultPoint(ASSAULT_POINT, points)
                v:messageSpecial(textTable.ASSAULT_POINTS_OBTAINED, points)
            end
            v:setVar("AssaultComplete",1)
            v:startEvent(102)
        end
    end
end

function assaultUtil.adjustMobLevel(mob, mobID)
    local instance = mob:getInstance()
    local cap = instance:getLevelCap()

    if cap == 70 then
        cap = 5
    elseif cap == 60 then
        cap = 15
    elseif cap == 50 then
        cap = 25
    end
    instance:getEntity(bit.band(mobID, 0xFFF), xi.objType.MOB):setMobLevel(instance:getEntity(bit.band(mobID, 0xFFF), xi.objType.MOB):getMainLvl() - cap)
end

assaultUtil.missionInfo =
{
    [LEUJAOAM_CLEANSING]               = {suggestedLevel = 50, minimumPoints = 1000},
    [ORICHALCUM_SURVEY]                = {suggestedLevel = 50, minimumPoints = 1200},
    [ESCORT_PROFESSOR_CHANOIX]         = {suggestedLevel = 60, minimumPoints = 1100},
    [SHANARHA_GRASS_CONSERVATION]      = {suggestedLevel = 50, minimumPoints = 1333},
    [COUNTING_SHEEP]                   = {suggestedLevel = 60, minimumPoints = 1166},
    [SUPPLIES_RECOVERY]                = {suggestedLevel = 70, minimumPoints = 1000},
    [AZURE_EXPERIMENTS]                = {suggestedLevel = 70, minimumPoints = 1000},
    [IMPERIAL_CODE]                    = {suggestedLevel = 70, minimumPoints = 1333},
    [RED_VERSUS_BLUE]                  = {suggestedLevel = 70, minimumPoints = 1666},
    [BLOODY_RONDO]                     = {suggestedLevel = 70, minimumPoints = 1500},
    [IMPERIAL_AGENT_RESCUE]            = {suggestedLevel = 60, minimumPoints = 1100},
    [PREEMPTIVE_STRIKE]                = {suggestedLevel = 60, minimumPoints = 1000},
    [SAGELORD_ELIMINATION]             = {suggestedLevel = 70, minimumPoints = 1200},
    [BREAKING_MORALE]                  = {suggestedLevel = 60, minimumPoints = 1333},
    [THE_DOUBLE_AGENT]                 = {suggestedLevel = 70, minimumPoints = 1200},
    [IMPERIAL_TREASURE_RETRIEVAL]      = {suggestedLevel = 50, minimumPoints = 1200},
    [BLITZKRIEG]                       = {suggestedLevel = 70, minimumPoints = 1533},
    [MARIDS_IN_THE_MIST]               = {suggestedLevel = 70, minimumPoints = 1333},
    [AZURE_EXPERIMENTS]                = {suggestedLevel = 70, minimumPoints = 1000},
    [THE_SUSANOO_SHUFFLE]              = {suggestedLevel = 70, minimumPoints = 1500},
    [EXCAVATION_DUTY]                  = {suggestedLevel = 50, minimumPoints = 1100},
    [LEBROS_SUPPLIES]                  = {suggestedLevel = 60, minimumPoints = 1200},
    [TROLL_FUGITIVES]                  = {suggestedLevel = 70, minimumPoints = 1000},
    [EVADE_AND_ESCAPE]                 = {suggestedLevel = 70, minimumPoints = 1000},
    [SIEGEMASTER_ASSASSINATION]        = {suggestedLevel = 70, minimumPoints = 1100},
    [APKALLU_BREEDING]                 = {suggestedLevel = 60, minimumPoints = 1300},
    [WAMOURA_FARM_RAID]                = {suggestedLevel = 70, minimumPoints = 1166},
    [EGG_CONSERVATION]                 = {suggestedLevel = 70, minimumPoints = 1333},
    [OPERATION__BLACK_PEARL]           = {suggestedLevel = 70, minimumPoints = 1400},
    [BETTER_THAN_ONE]                  = {suggestedLevel = 70, minimumPoints = 1500},
    [SEAGULL_GROUNDED]                 = {suggestedLevel = 70, minimumPoints = 1100},
    [REQUIEM]                          = {suggestedLevel = 70, minimumPoints = 1000},
    [SAVING_PRIVATE_RYAAF]             = {suggestedLevel = 70, minimumPoints = 1100},
    [SHOOTING_DOWN_THE_BARON]          = {suggestedLevel = 60, minimumPoints = 1100},
    [BUILDING_BRIDGES]                 = {suggestedLevel = 70, minimumPoints = 1200},
    [STOP_THE_BLOODSHED]               = {suggestedLevel = 50, minimumPoints = 1000},
    [DEFUSE_THE_THREAT]                = {suggestedLevel = 60, minimumPoints = 1600},
    [OPERATION__SNAKE_EYES]            = {suggestedLevel = 70, minimumPoints = 1333},
    [WAKE_THE_PUPPET]                  = {suggestedLevel = 70, minimumPoints = 1200},
    [THE_PRICE_IS_RIGHT]               = {suggestedLevel = 70, minimumPoints = 1500},
    [GOLDEN_SALVAGE]                   = {suggestedLevel = 60, minimumPoints = 1100},
    [LAMIA_NO_13]                      = {suggestedLevel = 70, minimumPoints = 1200},
    [EXTERMINATION]                    = {suggestedLevel = 70, minimumPoints = 1100},
    [DEMOLITION_DUTY]                  = {suggestedLevel = 50, minimumPoints = 1000},
    [SEARAT_SALVATION]                 = {suggestedLevel = 60, minimumPoints = 1166},
    [APKALLU_SEIZURE]                  = {suggestedLevel = 70, minimumPoints = 1000},
    [LOST_AND_FOUND]                   = {suggestedLevel = 60, minimumPoints = 1000},
    [DESERTER]                         = {suggestedLevel = 70, minimumPoints = 1000},
    [DESPERATELY_SEEKING_CEPHALOPODS]  = {suggestedLevel = 70, minimumPoints = 1000},
    [BELLEROPHON_S_BLISS]              = {suggestedLevel = 70, minimumPoints = 1500},
    [NYZUL_ISLE_INVESTIGATION]         = {suggestedLevel = 75, minimumPoints = nil},
    [NYZUL_ISLE_UNCHARTED_AREA_SURVEY] = {suggestedLevel = 99, minimumPoints = nil},
}
