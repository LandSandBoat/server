-----------------------------------
-- Assault Utilities
-- desc: Common functionality for Assaults
-----------------------------------
require("scripts/globals/besieged")
require("scripts/globals/npc_util")
require("scripts/globals/zone")
-----------------------------------
xi = xi or {}
xi.assault = xi.assault or {}
-----------------------------------

xi.assault.assaultArea =
{
    LEUJAOAM_SANCTUM           = 0,
    MAMOOL_JA_TRAINING_GROUNDS = 1,
    LEBROS_CAVERN              = 2,
    PERIQIA                    = 3,
    ILRUSI_ATOLL               = 4,
    NYZUL_ISLE                 = 5,
}

xi.assault.getAssaultArea = function(player)
    return math.floor((player:getCurrentAssault() - 1) / 10)
end

xi.assault.assaultOrders =
{
    xi.ki.LEUJAOAM_ASSAULT_ORDERS, xi.ki.MAMOOL_JA_ASSAULT_ORDERS, xi.ki.LEBROS_ASSAULT_ORDERS,
    xi.ki.PERIQIA_ASSAULT_ORDERS,  xi.ki.ILRUSI_ASSAULT_ORDERS, xi.ki.NYZUL_ISLE_ASSAULT_ORDERS,
}

xi.assault.hasOrders = function(player)
    for _, assaultOrders in pairs(xi.assault.assaultOrders) do
        if player:hasKeyItem(assaultOrders) then
            return true
        end
    end

    return false
end

xi.assault.onAssaultUpdate = function(player, csid, option)
    local ID = zones[player:getZoneID()]
    local npc = player:getEventTarget()

    local cap = bit.band(option, 0x03)
    if cap == 0 then
        cap = 0
    elseif cap == 1 then
        cap = 70
    elseif cap == 2 then
        cap = 60
    else
        cap = 50
    end

    player:setLocalVar("AssaultCap", cap)

    if
        player:getGMLevel() == 0 and
        player:getPartySize() < xi.settings.main.ASSAULT_MINIMUM
    then
        player:messageSpecial(ID.text.MEMBER_TOO_FAR - 1, xi.settings.main.ASSAULT_MINIMUM)
        player:instanceEntry(npc, 1)
        return
    elseif player:checkSoloPartyAlliance() == 2 then
        player:messageText(player, ID.text.MEMBER_NO_REQS + 1, false)
        player:instanceEntry(npc, 1)
        return
    end
end

xi.assault.onInstanceCreatedCallback = function(player, instance)
    if instance then
        instance:setLevelCap(player:getLocalVar("AssaultCap"))
        player:setLocalVar("AssaultCap", 0)
        player:setCharVar("Assault_Armband", 1)
        player:delKeyItem(xi.ki.ASSAULT_ARMBAND)
    else
        local npc = player:getEventTarget()
        player:messageText(player, zones[player:getZoneID()].text.CANNOT_ENTER, false)
        player:instanceEntry(npc, 3)
    end
end

xi.assault.afterInstanceRegister = function(player, fireFlies)
    local instance = player:getInstance()
    local assaultID = player:getCurrentAssault()
    local levelCap = instance:getLevelCap()
    local ID = zones[player:getZoneID()]

    player:setCharVar("assaultEntered", assaultID)
    player:messageSpecial(ID.text.ASSAULT_START_OFFSET + assaultID, assaultID)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
    player:addTempItem(fireFlies)

    if levelCap ~= 0 then
        player:addStatusEffect(xi.effect.LEVEL_RESTRICTION, levelCap, 0, 0)
    end

    for _, entity in pairs(ID.mob[assaultID].MOBS_START) do
        SpawnMob(entity, instance)
    end
end

xi.assault.onInstanceFailure = function(instance)
    local chars = instance:getChars()
    local mobs = instance:getMobs()

    for _, entity in pairs(mobs) do
        local mobID = entity:getID()
        DespawnMob(mobID, instance)
    end

    for _, entity in pairs(chars) do
        entity:messageSpecial(zones[instance:getZone():getID()].text.MISSION_FAILED, 10, 10)
        entity:startEvent(102)
    end
end

xi.assault.onInstanceComplete = function(instance, posX, posZ)
    local chars = instance:getChars()
    local ID = zones[instance:getZone():getID()]

    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setStatus(xi.status.NORMAL)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setStatus(xi.status.NORMAL)

    for _, entity in pairs(chars) do
        entity:messageSpecial(ID.text.RUNE_UNLOCKED_POS, posX, posZ)
    end
end

xi.assault.instanceOnEventFinish = function(player, csid, zone)
    if csid == 102 then
        local instance = player:getInstance()
        local chars = instance:getChars()
        for _, entity in pairs(chars) do
            entity:setPos(0, 0, 0, 0, zone)
        end
    end
end

xi.assault.runeReleaseFinish = function(player, csid, option)
    if csid == 100 and option == 1 then
        local instance = player:getInstance()
        local chars = instance:getChars()
        local zone = player:getZoneID()
        local ID = zones[zone]
        local playerpoints = math.max((#chars - 3) * 0.1, 0)
        local points = 0
        local assaultID = player:getCurrentAssault()
        local mobs = instance:getMobs()
        local pointsArea = xi.assault.getAssaultArea(player)

        for _, entity in pairs(mobs) do
            local mobID = entity:getID()
            DespawnMob(mobID, instance)
        end

        for _, entity in pairs(chars) do
            if entity:getLocalVar("AssaultPointsAwarded") == 0 then
                entity:setLocalVar("AssaultPointsAwarded", 1)

                local pointModifier = xi.assault.missionInfo[assaultID].minimumPoints
                points = pointModifier - (pointModifier * playerpoints)
                if entity:getCharVar("Assault_Armband") == 1 then
                    points = points * 1.1
                end

                if entity:hasCompletedAssault(assaultID) then
                    points = math.floor(points)
                    entity:setVar("AssaultPromotion", entity:getCharVar("AssaultPromotion") + 1)
                    entity:addAssaultPoint(pointsArea, points)
                    entity:messageSpecial(ID.text.ASSAULT_POINTS_OBTAINED, points)
                else
                    points = math.floor(points * 1.5)
                    entity:setVar("AssaultPromotion", entity:getCharVar("AssaultPromotion") + 5)
                    entity:addAssaultPoint(pointsArea, points)
                    entity:messageSpecial(ID.text.ASSAULT_POINTS_OBTAINED, points)
                end

                entity:setVar("AssaultComplete", 1)
                entity:startEvent(102)
            end
        end
    end
end

xi.assault.adjustMobLevel = function(mob)
    local instance = mob:getInstance()
    local levelCap = instance:getLevelCap()
    local reducedLevel = 0
    local entity = GetMobByID(mob:getID(), instance)

    if levelCap ~= 0 then
        if levelCap == 70 then
            reducedLevel = 5
        elseif levelCap == 60 then
            reducedLevel = 15
        elseif levelCap == 50 then
            reducedLevel = 25
        end

        entity:setMobLevel(entity:getMainLvl() - reducedLevel)
    end
end

xi.assault.mission =
{
    LEUJAOAM_CLEANSING                = 1,
    ORICHALCUM_SURVEY                 = 2,
    ESCORT_PROFESSOR_CHANOIX          = 3,
    SHANARHA_GRASS_CONSERVATION       = 4,
    COUNTING_SHEEP                    = 5,
    SUPPLIES_RECOVERY                 = 6,
    AZURE_EXPERIMENTS                 = 7,
    IMPERIAL_CODE                     = 8,
    RED_VERSUS_BLUE                   = 9,
    BLOODY_RONDO                      = 10,
    IMPERIAL_AGENT_RESCUE             = 11,
    PREEMPTIVE_STRIKE                 = 12,
    SAGELORD_ELIMINATION              = 13,
    BREAKING_MORALE                   = 14,
    THE_DOUBLE_AGENT                  = 15,
    IMPERIAL_TREASURE_RETRIEVAL       = 16,
    BLITZKRIEG                        = 17,
    MARIDS_IN_THE_MIST                = 18,
    AZURE_AILMENTS                    = 19,
    THE_SUSANOO_SHUFFLE               = 20,
    EXCAVATION_DUTY                   = 21,
    LEBROS_SUPPLIES                   = 22,
    TROLL_FUGITIVES                   = 23,
    EVADE_AND_ESCAPE                  = 24,
    SIEGEMASTER_ASSASSINATION         = 25,
    APKALLU_BREEDING                  = 26,
    WAMOURA_FARM_RAID                 = 27,
    EGG_CONSERVATION                  = 28,
    OPERATION__BLACK_PEARL            = 29,
    BETTER_THAN_ONE                   = 30,
    SEAGULL_GROUNDED                  = 31,
    REQUIEM                           = 32,
    SAVING_PRIVATE_RYAAF              = 33,
    SHOOTING_DOWN_THE_BARON           = 34,
    BUILDING_BRIDGES                  = 35,
    STOP_THE_BLOODSHED                = 36,
    DEFUSE_THE_THREAT                 = 37,
    OPERATION__SNAKE_EYES             = 38,
    WAKE_THE_PUPPET                   = 39,
    THE_PRICE_IS_RIGHT                = 40,
    GOLDEN_SALVAGE                    = 41,
    LAMIA_NO_13                       = 42,
    EXTERMINATION                     = 43,
    DEMOLITION_DUTY                   = 44,
    SEARAT_SALVATION                  = 45,
    APKALLU_SEIZURE                   = 46,
    LOST_AND_FOUND                    = 47,
    DESERTER                          = 48,
    DESPERATELY_SEEKING_CEPHALOPODS   = 49,
    BELLEROPHON_S_BLISS               = 50,
    NYZUL_ISLE_INVESTIGATION          = 51,
    NYZUL_ISLE_UNCHARTED_AREA_SURVEY  = 52,
}

xi.assault.missionInfo =
{
    [xi.assault.mission.LEUJAOAM_CLEANSING]               = { suggestedLevel = 50, minimumPoints = 1000 },
    [xi.assault.mission.ORICHALCUM_SURVEY]                = { suggestedLevel = 50, minimumPoints = 1200 },
    [xi.assault.mission.ESCORT_PROFESSOR_CHANOIX]         = { suggestedLevel = 60, minimumPoints = 1100 },
    [xi.assault.mission.SHANARHA_GRASS_CONSERVATION]      = { suggestedLevel = 50, minimumPoints = 1333 },
    [xi.assault.mission.COUNTING_SHEEP]                   = { suggestedLevel = 60, minimumPoints = 1166 },
    [xi.assault.mission.SUPPLIES_RECOVERY]                = { suggestedLevel = 70, minimumPoints = 1000 },
    [xi.assault.mission.AZURE_EXPERIMENTS]                = { suggestedLevel = 70, minimumPoints = 1000 },
    [xi.assault.mission.IMPERIAL_CODE]                    = { suggestedLevel = 70, minimumPoints = 1333 },
    [xi.assault.mission.RED_VERSUS_BLUE]                  = { suggestedLevel = 70, minimumPoints = 1666 },
    [xi.assault.mission.BLOODY_RONDO]                     = { suggestedLevel = 70, minimumPoints = 1500 },
    [xi.assault.mission.IMPERIAL_AGENT_RESCUE]            = { suggestedLevel = 60, minimumPoints = 1100 },
    [xi.assault.mission.PREEMPTIVE_STRIKE]                = { suggestedLevel = 60, minimumPoints = 1000 },
    [xi.assault.mission.SAGELORD_ELIMINATION]             = { suggestedLevel = 70, minimumPoints = 1200 },
    [xi.assault.mission.BREAKING_MORALE]                  = { suggestedLevel = 60, minimumPoints = 1333 },
    [xi.assault.mission.THE_DOUBLE_AGENT]                 = { suggestedLevel = 70, minimumPoints = 1200 },
    [xi.assault.mission.IMPERIAL_TREASURE_RETRIEVAL]      = { suggestedLevel = 50, minimumPoints = 1200 },
    [xi.assault.mission.BLITZKRIEG]                       = { suggestedLevel = 70, minimumPoints = 1533 },
    [xi.assault.mission.MARIDS_IN_THE_MIST]               = { suggestedLevel = 70, minimumPoints = 1333 },
    [xi.assault.mission.AZURE_EXPERIMENTS]                = { suggestedLevel = 70, minimumPoints = 1000 },
    [xi.assault.mission.THE_SUSANOO_SHUFFLE]              = { suggestedLevel = 70, minimumPoints = 1500 },
    [xi.assault.mission.EXCAVATION_DUTY]                  = { suggestedLevel = 50, minimumPoints = 1100 },
    [xi.assault.mission.LEBROS_SUPPLIES]                  = { suggestedLevel = 60, minimumPoints = 1200 },
    [xi.assault.mission.TROLL_FUGITIVES]                  = { suggestedLevel = 70, minimumPoints = 1000 },
    [xi.assault.mission.EVADE_AND_ESCAPE]                 = { suggestedLevel = 70, minimumPoints = 1000 },
    [xi.assault.mission.SIEGEMASTER_ASSASSINATION]        = { suggestedLevel = 70, minimumPoints = 1100 },
    [xi.assault.mission.APKALLU_BREEDING]                 = { suggestedLevel = 60, minimumPoints = 1300 },
    [xi.assault.mission.WAMOURA_FARM_RAID]                = { suggestedLevel = 70, minimumPoints = 1166 },
    [xi.assault.mission.EGG_CONSERVATION]                 = { suggestedLevel = 70, minimumPoints = 1333 },
    [xi.assault.mission.OPERATION__BLACK_PEARL]           = { suggestedLevel = 70, minimumPoints = 1400 },
    [xi.assault.mission.BETTER_THAN_ONE]                  = { suggestedLevel = 70, minimumPoints = 1500 },
    [xi.assault.mission.SEAGULL_GROUNDED]                 = { suggestedLevel = 70, minimumPoints = 1100 },
    [xi.assault.mission.REQUIEM]                          = { suggestedLevel = 70, minimumPoints = 1000 },
    [xi.assault.mission.SAVING_PRIVATE_RYAAF]             = { suggestedLevel = 70, minimumPoints = 1100 },
    [xi.assault.mission.SHOOTING_DOWN_THE_BARON]          = { suggestedLevel = 60, minimumPoints = 1100 },
    [xi.assault.mission.BUILDING_BRIDGES]                 = { suggestedLevel = 70, minimumPoints = 1200 },
    [xi.assault.mission.STOP_THE_BLOODSHED]               = { suggestedLevel = 50, minimumPoints = 1000 },
    [xi.assault.mission.DEFUSE_THE_THREAT]                = { suggestedLevel = 60, minimumPoints = 1600 },
    [xi.assault.mission.OPERATION__SNAKE_EYES]            = { suggestedLevel = 70, minimumPoints = 1333 },
    [xi.assault.mission.WAKE_THE_PUPPET]                  = { suggestedLevel = 70, minimumPoints = 1200 },
    [xi.assault.mission.THE_PRICE_IS_RIGHT]               = { suggestedLevel = 70, minimumPoints = 1500 },
    [xi.assault.mission.GOLDEN_SALVAGE]                   = { suggestedLevel = 60, minimumPoints = 1100 },
    [xi.assault.mission.LAMIA_NO_13]                      = { suggestedLevel = 70, minimumPoints = 1200 },
    [xi.assault.mission.EXTERMINATION]                    = { suggestedLevel = 70, minimumPoints = 1100 },
    [xi.assault.mission.DEMOLITION_DUTY]                  = { suggestedLevel = 50, minimumPoints = 1000 },
    [xi.assault.mission.SEARAT_SALVATION]                 = { suggestedLevel = 60, minimumPoints = 1166 },
    [xi.assault.mission.APKALLU_SEIZURE]                  = { suggestedLevel = 70, minimumPoints = 1000 },
    [xi.assault.mission.LOST_AND_FOUND]                   = { suggestedLevel = 60, minimumPoints = 1000 },
    [xi.assault.mission.DESERTER]                         = { suggestedLevel = 70, minimumPoints = 1000 },
    [xi.assault.mission.DESPERATELY_SEEKING_CEPHALOPODS]  = { suggestedLevel = 70, minimumPoints = 1000 },
    [xi.assault.mission.BELLEROPHON_S_BLISS]              = { suggestedLevel = 70, minimumPoints = 1500 },
    [xi.assault.mission.NYZUL_ISLE_INVESTIGATION]         = { suggestedLevel = 75, minimumPoints = nil  },
    [xi.assault.mission.NYZUL_ISLE_UNCHARTED_AREA_SURVEY] = { suggestedLevel = 99, minimumPoints = nil  },
}
