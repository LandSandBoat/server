-----------------------------------
-- Dominion Sergeant Global
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
xi = xi or {}
xi.abyssea = xi.abyssea or {}

-- Grauberg
-- Cornelia's Camp: !pos -15.513 0.64 -482.04 254

local sergeantData =
{-- NPC Name              Zone                   CSID  OpMask
    ['DSgt_Cornelia'] = { xi.zone.ABYSSEA_ALTEPA, 501, 6606 },
}

local opZone =
{
    [xi.zone.ABYSSEA_ALTEPA    ] = 0,
    [xi.zone.ABYSSEA_ULEGUERAND] = 1,
    [xi.zone.ABYSSEA_GRAUBERG  ] = 2,
}

-- TODO: baseRewardValue should be XP reward at 75
-- Cruor reward = (baseXP@75 / 10) * 2
-- Dominion Note reward = (baseXP@75 / 10)
local baseRewardValue = 600
local dominionOpQuests =
{
    -- Abyssea - Altepa
    [560] = { xi.quest.id.abyssea.DOMINION_OP_01_ALTEPA, 5, baseRewardValue },
    [561] = { xi.quest.id.abyssea.DOMINION_OP_02_ALTEPA, 5, baseRewardValue },
    [562] = { xi.quest.id.abyssea.DOMINION_OP_03_ALTEPA, 5, baseRewardValue },
    [563] = { xi.quest.id.abyssea.DOMINION_OP_04_ALTEPA, 5, baseRewardValue },
    [564] = { xi.quest.id.abyssea.DOMINION_OP_05_ALTEPA, 5, baseRewardValue },
    [565] = { xi.quest.id.abyssea.DOMINION_OP_06_ALTEPA, 5, baseRewardValue },
    [566] = { xi.quest.id.abyssea.DOMINION_OP_07_ALTEPA, 5, baseRewardValue },
    [567] = { xi.quest.id.abyssea.DOMINION_OP_08_ALTEPA, 5, baseRewardValue },
    [568] = { xi.quest.id.abyssea.DOMINION_OP_09_ALTEPA, 5, baseRewardValue },
    [569] = { xi.quest.id.abyssea.DOMINION_OP_10_ALTEPA, 5, baseRewardValue },
    [570] = { xi.quest.id.abyssea.DOMINION_OP_11_ALTEPA, 5, baseRewardValue },
    [571] = { xi.quest.id.abyssea.DOMINION_OP_12_ALTEPA, 5, baseRewardValue },
    [572] = { xi.quest.id.abyssea.DOMINION_OP_13_ALTEPA, 5, baseRewardValue },
    [573] = { xi.quest.id.abyssea.DOMINION_OP_14_ALTEPA, 5, baseRewardValue },

    -- Abyssea - Uleguerand
    [574] = { xi.quest.id.abyssea.DOMINION_OP_01_ULEGUERAND, 5, baseRewardValue },
    [575] = { xi.quest.id.abyssea.DOMINION_OP_02_ULEGUERAND, 5, baseRewardValue },
    [576] = { xi.quest.id.abyssea.DOMINION_OP_03_ULEGUERAND, 5, baseRewardValue },
    [577] = { xi.quest.id.abyssea.DOMINION_OP_04_ULEGUERAND, 5, baseRewardValue },
    [578] = { xi.quest.id.abyssea.DOMINION_OP_05_ULEGUERAND, 5, baseRewardValue },
    [579] = { xi.quest.id.abyssea.DOMINION_OP_06_ULEGUERAND, 5, baseRewardValue },
    [580] = { xi.quest.id.abyssea.DOMINION_OP_07_ULEGUERAND, 5, baseRewardValue },
    [581] = { xi.quest.id.abyssea.DOMINION_OP_08_ULEGUERAND, 5, baseRewardValue },
    [582] = { xi.quest.id.abyssea.DOMINION_OP_09_ULEGUERAND, 5, baseRewardValue },
    [583] = { xi.quest.id.abyssea.DOMINION_OP_10_ULEGUERAND, 5, baseRewardValue },
    [584] = { xi.quest.id.abyssea.DOMINION_OP_11_ULEGUERAND, 5, baseRewardValue },
    [585] = { xi.quest.id.abyssea.DOMINION_OP_12_ULEGUERAND, 5, baseRewardValue },
    [586] = { xi.quest.id.abyssea.DOMINION_OP_13_ULEGUERAND, 5, baseRewardValue },
    [587] = { xi.quest.id.abyssea.DOMINION_OP_14_ULEGUERAND, 5, baseRewardValue },

    -- Abyssea - Grauberg
    [588] = { xi.quest.id.abyssea.DOMINION_OP_01_GRAUBERG, 5, baseRewardValue },
    [589] = { xi.quest.id.abyssea.DOMINION_OP_02_GRAUBERG, 5, baseRewardValue },
    [590] = { xi.quest.id.abyssea.DOMINION_OP_03_GRAUBERG, 5, baseRewardValue },
    [591] = { xi.quest.id.abyssea.DOMINION_OP_04_GRAUBERG, 5, baseRewardValue },
    [592] = { xi.quest.id.abyssea.DOMINION_OP_05_GRAUBERG, 5, baseRewardValue },
    [593] = { xi.quest.id.abyssea.DOMINION_OP_06_GRAUBERG, 5, baseRewardValue },
    [594] = { xi.quest.id.abyssea.DOMINION_OP_07_GRAUBERG, 5, baseRewardValue },
    [595] = { xi.quest.id.abyssea.DOMINION_OP_08_GRAUBERG, 5, baseRewardValue },
    [596] = { xi.quest.id.abyssea.DOMINION_OP_09_GRAUBERG, 5, baseRewardValue },
    [597] = { xi.quest.id.abyssea.DOMINION_OP_10_GRAUBERG, 5, baseRewardValue },
    [598] = { xi.quest.id.abyssea.DOMINION_OP_11_GRAUBERG, 5, baseRewardValue },
    [599] = { xi.quest.id.abyssea.DOMINION_OP_12_GRAUBERG, 5, baseRewardValue },
    [600] = { xi.quest.id.abyssea.DOMINION_OP_13_GRAUBERG, 5, baseRewardValue },
    [601] = { xi.quest.id.abyssea.DOMINION_OP_14_GRAUBERG, 5, baseRewardValue },
}

-- Dominion Op XP Range is listed as 600~4950, which is up to an 8x even multiplier
-- Set bonus to (float)basexp * (1 + (influencePct/12.5)) ? TODO: Research amounts vs influence
-- Set charVar for active dominion op
-- Low chance of valid seals, seals by zone or quest?

local function getPackedInfluenceList(zoneID)
    local packedInfluence = { 0, 0, 0, 0 }

    for serverVarID = 1, 4 do
        packedInfluence[serverVarID] = GetServerVariable('dOpInfluence[' .. zoneID .. '][' .. serverVarID .. ']')
    end

    return packedInfluence
end
--[[
local function savePackedInfluenceList(zoneID, influenceList)
    local packedInfluenceData = { 0, 0, 0, 0 }

    for opNumber = 1, 14 do
        local serverVarID = math.floor((opNumber - 1) / 4) + 1
        local bitOffset = ((opNumber - 1) % 4) * 8

        packedInfluenceData[serverVarID] = packedInfluenceData[serverVarID] + bit.lshift(influenceList[opNumber], bitOffset)
    end

    for serverVarID = 1, 4 do
        SetServerVariable('dOpInfluence[' .. zoneID .. '][' .. serverVarID .. ']', packedInfluenceData[serverVarID])
    end
end

local function getOpInfluenceList(zoneID)
    local influenceTable = { }

    for serverVarID = 1, 4 do
        local packedData = GetServerVariable('dOpInfluence[' .. zoneID .. '][' .. serverVarID .. ']')

        local startIndex = (serverVarID - 1) * 4 + 1
        for opNumber = startIndex, startIndex + 3 do
            if opNumber > 14 then
                break
            end

            influenceTable[opNumber] = bit.band(bit.rshift(packedData, 8 * (opNumber - 1)), 0xFF)
        end
    end

    return influenceTable
end
]]--
xi.abyssea.dominionOnMobDeath = function(mob, player, dominionOpID)

end

xi.abyssea.sergeantOnTrigger = function(player, npc)
    local sergeantInfo = sergeantData[npc:getName()]
    local packedInfluence = getPackedInfluenceList(player:getZoneID())
    local activeOp = player:getCharVar('activeDominionOp')
    local dominionNotes = player:getCurrency("dominion_note")

    -- Parameters (COMMON):
    -- 8 = Op Status: 0 = None Active, 1 = Active Op, 2 = Op Completed in correct Zone, 3 = (Guess) Op complete but in another area

    -- Parameters (IF NO OP ACTIVE):
    -- 5 = bit.rshift(param, 1) -> Bitmask, 1 disables, 0 enables (1..14) availability
    -- 6 = ???
    -- 7 = Total Dominion Notes, does not appear to be used but is updated!
    -- 8 = Common Parameter

    -- TODO: Handle invalid zone and completes in the quest scripts (Param8)
    if activeOp == 0 then
        player:startEvent(sergeantInfo[2], packedInfluence[1], packedInfluence[2], packedInfluence[3], packedInfluence[4], sergeantInfo[3], 0, dominionNotes, 0)
    end

    -- Parameters (IF OP ACTIVE)
    -- 1 = Active Op ID
    -- 2 = Total kills required
    -- 3 = Kills achieved
    -- 8 = Common Parameter
    -- player:startEvent(501, 560, 5, 4, 0, 0, 0, 0, 3)
end

xi.abyssea.sergeantOnEventUpdate = function(player, csid, option)
    local updateType = bit.band(option, 0xF)

    -- updateType 2: Partake Option, display Op Info
    if updateType == 2 then
        local selectedOp = bit.rshift(option, 4)
        local opID = 559 + opZone[player:getZoneID()] * 14 + selectedOp

        player:updateEvent(dominionOpQuests[opID][2], 0, 0, 0, 0, 0, 0, opID)

    -- updateType 2: Partake Option, display Op Difficulty (0-indexed, 1..5 stars displayed)
    elseif updateType == 6 then
        player:updateEvent(1)

    -- Show sphere of influence bonuses
    -- TODO
    elseif updateType == 9 then
        player:updateEvent(2, 2, 2, 2, 2, 2, 1, 256)
    end
end

xi.abyssea.sergeantOnEventFinish = function(player, csid, option, npc)
    local finishType = bit.band(option, 0xF)

    if finishType == 2 then
        local selectedOp = bit.rshift(option, 4)

        print(selectedOp)
    elseif finishType == 3 then

    end

    printf("%i", option)
end
